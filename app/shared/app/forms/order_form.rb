class OrderForm < Dry::Struct
  transform_keys(&:to_sym)

  attribute :user_id,          Types::Strict::Integer
  attribute :collect_method,   Types::Strict::String.default { 'timeline' }
  attribute :archive_url,      Types::Strict::String.optional.default { nil }
  attribute :start_message,    Types::Strict::String.default { '' }
  attribute :finish_message,   Types::Strict::String.default { '' }
  attribute :protect_reply,    Types::Params::Bool.default { false }
  attribute :protect_favorite, Types::Params::Bool.default { false }
  attribute :collect_from,     Types::Strict::String.default { '' }
  attribute :collect_to,       Types::Strict::String.default { '' }
  attribute :signedin_at,      Types::Strict::DateTime.default { Time.current }

  def user
    @user ||= User.find(user_id)
  end

  def order
    @order ||= begin
      Order.new do |order|
        order.user_id = user_id
        order.build_parameter do |parameter|
          parameter.collect_method   = collect_method
          parameter.archive_url      = archive_url.presence
          parameter.start_message    = start_message
          parameter.finish_message   = finish_message
          parameter.protect_reply    = protect_reply
          parameter.protect_favorite = protect_favorite
          parameter.collect_from     = collect_from.presence
          parameter.collect_to       = collect_to.presence
          parameter.signedin_at      = signedin_at
        end
      end
    end
  end

  def notification_message
    @notification_message ||= NotificationMessage.find_by_random
  end

  def start_message
    "@#{user.name} #{notification_message.start}"
  end

  def finish_message
    "@#{user.name} #{notification_message.finish}"
  end

  def valid?
    order.valid?
  end

  def save!
    order.save!
  end
end
