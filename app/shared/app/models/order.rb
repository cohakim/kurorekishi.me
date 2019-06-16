# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  user_id           :bigint           not null
#  transition_state  :integer          not null
#  progression_state :integer          not null
#  collect_count     :integer          default(0), not null
#  destroy_count     :integer          default(0), not null
#  processed_at      :datetime
#  confirmed_at      :datetime
#  closed_at         :datetime
#  collected_at      :datetime
#  destroyed_at      :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_orders_on_progression_state  (progression_state)
#  index_orders_on_transition_state   (transition_state)
#  index_orders_on_user_id            (user_id)
#

class Order < ApplicationRecord
  has_one :parameter, dependent: :destroy
  has_one_attached :collect_log_book
  belongs_to :user

  scope :user, ->(user) { where(user: user) }
  scope :active, -> { where(transition_state: %i(processing confirming closing)) }

  validates_uniqueness_of :user_id, conditions: -> { active }, message: 'already has an active order'

  delegate :credentials, to: :user
  delegate :collect_params, to: :parameter

  ##############################################################################
  include AASM
  enum transition_state: { processing: 0, confirming: 1, closing: 2, closed: 99 }
  aasm :transition, column: :transition_state, enum: true do
    state :processing, initial: true
    state :confirming
    state :closing
    state :closed

    event :process do
      after do
        update! processed_at: Time.current
      end
      transitions from: :processing, to: :confirming
      transitions from: :confirming, to: :confirming
      transitions from: :closing,    to: :closing
      transitions from: :closed,     to: :closed
    end

    event :confirm do
      transitions from: :confirming, to: :closing
    end

    event :close do
      transitions from: :closing, to: :closed
    end
  end

  enum progression_state: {
    created:     0,
    collected:   1,
    cleaned:     2,
    completed: 200,
    aborted:   500,
    failed:    501,
    expired:   502,
  }
  aasm :progression, column: :progression_state, enum: true do
    state :created, initial: true
    state :collected
    state :cleaned
    state :completed
    state :aborted
    state :failed
    state :expired

    event :finish_collect do
      transitions from: :created, to: :collected, after: ->(args) do
        assign_attributes args.extract!(:collect_count)
        assign_attributes collected_at: Time.current
      end
    end

    event :finish_clean do
      transitions from: :collected, to: :cleaned, after: ->(args) do
        assign_attributes args.extract!(:destroy_count)
        assign_attributes destroyed_at: Time.current
      end
    end

    event :complete, binding_event: :process do
      transitions from: :cleaned, to: :completed
    end

    event :abort, binding_event: :process do
      transitions from: %i(created collected), to: :aborted
    end

    event :fail, binding_event: :process do
      transitions from: %i(created collected cleaned), to: :failed
    end

    event :expire, binding_event: :process do
      transitions from: %i(created collected cleaned), to: :expired
    end
  end

  def collecting?
    created?
  end

  def cleaning?
    collected?
  end
end
