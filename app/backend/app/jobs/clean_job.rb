class CleanJob < ApplicationJob
  queue_as 'default.fifo'

  def perform(order_id)
    order = Order.find(order_id)
    CollectService.call(order)
    DestroyService.call(order)
  rescue => ex
    # TODO: 例外を通知する
    order.fail!
  end
end
