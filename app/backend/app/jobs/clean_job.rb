class CleanJob < ApplicationJob
  queue_as 'default'

  def perform(order_id)
    order = Order.find(order_id)

    CollectService.call(order)
    NotifyService.call(:start_message, order)
    DestroyService.call(order)
    NotifyService.call(:finish_message, order)
  rescue => ex
    order.fail! if order.may_fail?
    raise ex
  end
end
