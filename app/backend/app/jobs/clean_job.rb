class CleanJob < ApplicationJob
  queue_as 'default'

  def perform(order_id)
    order = Order.find(order_id)
    CollectService.call(order)
    DestroyService.call(order)
  rescue => ex
    order.fail!
    raise ex
  end
end
