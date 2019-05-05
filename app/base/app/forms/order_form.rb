class OrderForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :user_id,          :big_integer
  attribute :collect_method,   :string,   default: -> { 'timeline' }
  attribute :archive_url,      :string,   default: -> { nil }
  attribute :start_message,    :string,   default: -> { '' }
  attribute :finish_message,   :string,   default: -> { '' }
  attribute :protect_reply,    :boolean,  default: -> { false }
  attribute :protect_favorite, :boolean,  default: -> { false }
  attribute :collect_from,     :datetime, default: -> { nil }
  attribute :collect_to,       :datetime, default: -> { nil }
  attribute :signedin_at,      :datetime, default: -> { Time.current }

  validates :user_id, :collect_method, presence: true

  def save!
    order = Order.new do |order|
      order.user_id = user_id
      order.build_parameter do |parameter|
        parameter.collect_method   = collect_method
        parameter.archive_url      = archive_url
        parameter.start_message    = start_message
        parameter.finish_message   = finish_message
        parameter.protect_reply    = protect_reply
        parameter.protect_favorite = protect_favorite
        parameter.collect_from     = collect_from
        parameter.collect_to       = collect_to
        parameter.signedin_at      = signedin_at
      end
    end
    order.save!
  end
end
