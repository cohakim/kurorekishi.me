class RowOrientedJSONStream < File
  class << self
    def open(path)
      super(path, 'a+') do |f|
        yield f
      end
    end

    def row_count(path)
      lineno = 0
      File.open(path) do |file|
        nil while file.gets
        lineno = file.lineno
      end
      lineno
    end

    def prepare(path)
      FileUtils.mv(path, "#{path}.#{Time.current.strftime('%Y%m%d%H%M%S')}", force: true)
      FileUtils.mkdir_p File.dirname(path)
    end
  end

  def puts(tweet, serializer:)
    super serializer.new(tweet).to_json
  end

  def each_line
    super do |line|
      yield JSON.parse(line, object_class: OpenStruct)
    end
  end
end
