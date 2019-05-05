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
  has_one    :parameter, dependent: :destroy
  belongs_to :user

  scope :user, ->(user) { where(user: user) }
  scope :active, -> { where(transition_state: %i(processing confirming closing)) }

  validates_uniqueness_of :user_id, conditions: -> { active }, message: 'already has an active order'

  include AASM
  enum transition_state: { processing: 0, confirming: 70, closing: 80, closed: 99 }
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
    collecting:  1,
    collected:   2,
    cleaning:    3,
    cleaned:     4,
    completed:  80,
    aborted:    90,
    failed:     91,
    expired:    92,
  }
  aasm :progression, column: :progression_state, enum: true do
    state :created, initial: true
    state :collecting
    state :collected
    state :cleaning
    state :cleaned
    state :completed
    state :aborted
    state :failed
    state :expired

    event :start_collect do
      transitions from: %i(created), to: :collecting
    end

    event :finish_collect do
      transitions from: :collecting, to: :collected, after: ->(args) do
        assign_attributes args.extract!(:collect_count)
      end
    end

    event :start_clean do
      transitions from: :collected, to: :cleaning
    end

    event :finish_clean do
      transitions from: :cleaning, to: :cleaned, after: ->(args) do
        assign_attributes args.extract!(:destroy_count)
      end
    end

    event :complete, binding_event: :process do
      transitions from: :cleaned, to: :completed
    end

    event :abort, binding_event: :process do
      transitions from: %i(created collecting collected cleaning), to: :aborted
    end

    event :fail, binding_event: :process do
      transitions from: %i(created attached collecting collected cleaning cleaned), to: :failed
    end

    event :expire, binding_event: :process do
      transitions from: %i(created attached collecting collected cleaning cleaned), to: :expired
    end
  end
end
