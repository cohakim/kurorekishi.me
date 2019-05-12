class CollectService < Patterns::Service
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def call
    return unless order.may_finish_collect?

    row_count = 0
    collect_log_book = CollectLogBook.new(order)
    collect_service.collect!(order.credentials, order.collect_params) do |status|
      collect_log_book.append(status)
      row_count += 1
    end
    collect_log_book.save

    order.finish_collect!(collect_count: row_count)
  end

  private

  def collect_service
    ServiceLocator.resolve(:collect_service, order.collect_params.collect_method)
  end
end

