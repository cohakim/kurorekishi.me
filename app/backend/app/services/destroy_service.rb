class DestroyService < Patterns::Service
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def call
    return unless order.may_finish_clean?

    row_count = order.destroy_count
    threads = []
    retrieve_timeline(offset: row_count, take: 100) do |status|
      threads << Thread.new do
        # response = destroy_status(status)
        row_count += 1
      end
    end
    threads.each(&:join)

    if row_count < order.collect_count
      order.update!(destroy_count: row_count)
    else
      order.finish_clean!(destroy_count: row_count)
      order.complete!
    end
  end

  private

  def retrieve_timeline(offset: 0, take: 100)
    collect_log_book = CollectLogBook.new(order)
    collect_log_book.each_line(offset: offset, take: take) do |status|
      yield status
    end
  end

  def destroy_status(status)
    response = nil
    Retryable.retryable(tries: 5, sleep: 1) do
      response = twitter_client.destroy_status(status.id)
      fail Twitter::Error::ServerError if response.code.to_i.in? [500, 502, 503, 504]
    end
  ensure
    return response
  end

  def twitter_client
    @twitter_client ||= MagicalTwitterClient.new(order.credentials)
  end
end

