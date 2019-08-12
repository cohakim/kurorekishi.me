# == Schema Information
#
# Table name: orders
#
#  id                      :bigint           not null, primary key
#  user_id                 :bigint           not null
#  transition_state        :integer          not null
#  progression_state       :integer          not null
#  collect_count           :integer          default(0), not null
#  destroy_count           :integer          default(0), not null
#  processed_at            :datetime
#  confirmed_at            :datetime
#  closed_at               :datetime
#  collected_at            :datetime
#  destroyed_at            :datetime
#  start_message_notified  :boolean          default(FALSE), not null
#  finish_message_notified :boolean          default(FALSE), not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_orders_on_progression_state  (progression_state)
#  index_orders_on_transition_state   (transition_state)
#  index_orders_on_user_id            (user_id)
#

class OrderSerializer < ActiveModel::Serializer
  attributes :id

  has_one :parameter
end
