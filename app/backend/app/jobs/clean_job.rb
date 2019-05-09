class CleanJob < ApplicationJob
  def perform(order_id)
    order = Order.find(order_id)

    CollectService.call(order)
    DestroyService.call(order)
  end
end
