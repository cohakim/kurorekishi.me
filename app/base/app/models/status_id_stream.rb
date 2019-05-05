class StatusIdStream < RowOrientedJSONStream
  class << self
    def open(id)
      super Rails.root.join('tmp', id.to_s, 'status_id_stream')
    end

    def row_count(id)
      super Rails.root.join('tmp', id.to_s, 'status_id_stream')
    end

    def prepare(id)
      super Rails.root.join('tmp', id.to_s, 'status_id_stream')
    end
  end
end
