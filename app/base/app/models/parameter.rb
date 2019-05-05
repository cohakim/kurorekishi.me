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

class Parameter < ApplicationRecord
  belongs_to :order, dependent: :destroy

  enum collect_method: [:timeline, :archive]

  composed_of :collect_parameter, constructor: :construct, mapping: [
    %w(signedin_at signedin_at),
    %w(collect_method collect_method), %w(archive_url archive_url),
    %w(protect_reply protect_reply),   %w(protect_favorite protect_favorite),
    %w(collect_from collect_from),     %w(collect_to collect_to)
  ]
  composed_of :destroy_parameter, constructor: :construct, mapping: [
    %w(start_message start_message), %w(finish_message finish_message),
  ]
end
