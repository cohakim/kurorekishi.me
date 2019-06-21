class NotifyService < Patterns::Service
  attr_reader :context, :order

  def initialize(context, order)
    @context = context
    @order   = order
  end

  def call
    return if order.start_message_notified?

    twitter_client.post_status(message)
  rescue StandardError
    # do nothing
  ensure
    order.notify_start_message!
  end

  private

  def message
    case context
    when :start_message  then order.parameter.destroy_params.start_message
    when :finish_message then order.parameter.destroy_params.finish_message
    end
  end

  def twitter_client
    @twitter_client ||= MagicalTwitterClient.new(order.credentials)
  end
end
