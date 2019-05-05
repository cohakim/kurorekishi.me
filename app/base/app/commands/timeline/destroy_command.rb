class Timeline::DestroyCommand < Patterns::Command
  attr_reader :order, :credentials, :destroy_params

  def initialize(order:, credentials:, destroy_params:)
    @order          = order
    @credentials    = credentials
    @destroy_params = destroy_params
  end

  def call
    ProcessLogStream.prepare(order.id)

    row_count = 0
    with_stream(order.id) do |status, process_log_stream|
      destroy_service.destroy!(status_id: status.id, credentials: credentials) do |status_id, code, body|
        process_log = OpenStruct.new(id: status_id, code: code, body: body)
        process_log_stream.puts process_log, serializer: ProcessLogSerializer
        row_count += 1

        order.update!(destroy_count: row_count) if row_count % 100 == 0
      end
    end
    order.update!(destroy_count: row_count)
  end

  private

  def with_stream(order_id)
    ProcessLogStream.open(order_id) do |process_log_stream|
      StatusIdStream.open(order_id) do |status_id_stream|
        status_id_stream.each_line do |status|
          yield status, process_log_stream
        end
      end
    end
  end

  def destroy_service
    ServiceLocator.resolve(:destroy_service)
  end
end
