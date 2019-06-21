class NotifyService < Patterns::Service
  attr_reader :context, :order

  def initialize(context, order)
    @context = context
    @order   = order
  end

  def call
    return unless may_notify?

    twitter_client.post_status(message)
  rescue StandardError
    # do nothing
  ensure
    notify!
  end

  private

  def may_notify?
    if context == :start_message
      !order.start_message_notified?
    elsif context == :finish_message
      !order.finish_message_notified?
    else
      false
    end
  end

  def notify!
    if context == :start_message
      order.notify_start_message!
    elsif context == :finish_message
      order.notify_finish_message!
    else
      false
    end
  end

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
