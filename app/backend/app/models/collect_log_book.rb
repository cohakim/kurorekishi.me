class CollectLogBook
  include ActiveStorage::Downloading

  attr_reader :order, :tempfile

  def initialize(order)
    @order = order
    @tempfile = Tempfile.open
  end

  def append(status)
    tempfile.puts NormalizedStatus.new(status).to_json
  end

  def save
    tempfile.close
    order.collect_log_book.attach(
      io: File.open(tempfile.path),
      filename: "collect_log_#{order.id}",
      content_type: 'application/x-ldjson'
    )
    tempfile.unlink
  end

  def each_line(offset: 0, take: 100)
    download_blob_to_tempfile do |file|
      file.each_line do |line|
        if offset < file.lineno && file.lineno <= (offset + take)
          yield NormalizedStatus.new(JSON.parse(line, { symbolize_names: true }))
        end
      end
    end
  end

  private

  def blob
    order.collect_log_book.blob
  end
end
