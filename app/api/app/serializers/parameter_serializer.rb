# == Schema Information
#
# Table name: parameters
#
#  id               :bigint           not null, primary key
#  order_id         :bigint           not null
#  signedin_at      :datetime         not null
#  collect_method   :integer          not null
#  archive_url      :text(65535)
#  protect_reply    :boolean          default(FALSE), not null
#  protect_favorite :boolean          default(FALSE), not null
#  collect_from     :date
#  collect_to       :date
#  start_message    :text(65535)
#  finish_message   :text(65535)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_parameters_on_order_id  (order_id) UNIQUE
#

class ParameterSerializer < ActiveModel::Serializer
  attributes %i(
    order_id
    signedin_at
    collect_method
    archive_url
    protect_reply
    protect_favorite
    collect_from
    collect_to
    start_message
    finish_message
  )
end
