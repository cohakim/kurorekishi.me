class ProcessLogStream < RowOrientedJSONStream
  class << self
    def open(id)
      super Rails.root.join('tmp', id.to_s, 'process_log_stream')
    end

    def prepare(id)
      super Rails.root.join('tmp', id.to_s, 'process_log_stream')
    end
  end
end
