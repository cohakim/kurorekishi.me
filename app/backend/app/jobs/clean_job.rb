class CleanJob < ApplicationJob
  include Shoryuken::Worker

  queue_as 'default.fifo'
  shoryuken_options auto_delete: true, auto_visibility_timeout: true

  def perform(order_id)
    # order = Order.find(order_id)
    # CollectService.call(order)
    # DestroyService.call(order)
    sleep 100
  rescue => ex
    order.fail!
    raise ex
  end
end
