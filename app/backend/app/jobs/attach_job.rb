class AttachJob < ApplicationJob
  queue_as 'default'

  def perform
    Order.attachable.each do |order|
      CleanJob.perform_later(order.id)
    end
  end
end
