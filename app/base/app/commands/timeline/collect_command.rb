class Timeline::CollectCommand < Patterns::Command
  attr_reader :order, :credentials, :collect_params

  def initialize(order:, credentials:, collect_params:)
    @order          = order
    @credentials    = credentials
    @collect_params = collect_params
  end

  def call
    StatusIdStream.prepare(order.id)

    row_count = 0
    StatusIdStream.open(order.id) do |ss|
      collect_service.collect!(credentials, collect_params) do |tweet|
        ss.puts tweet, serializer: StatusIdSerializer
        row_count += 1
      end
    end
    order.update!(collect_count: row_count)
  end

  private

  def collect_service
    ServiceLocator.resolve(:collect_service, collect_params.collect_method)
  end
end
