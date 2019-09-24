class AttachJob < ApplicationJob
  def perform
    Order.attachable.each do |order|
      CleanJob.perform_async(order.id)
    end
  end
end
