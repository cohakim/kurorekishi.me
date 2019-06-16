class ServerStatus
  BUSYNESS_EMPTY  = :empty
  BUSYNESS_NORMAL = :normal
  BUSYNESS_JAM    = :jam
  BUSYNESS_HALT   = :halt

  attr_accessor :busyness, :processing_count

  class << self
    def current_server_status
      new.tap do |status|
        status.busyness         = busyness
        status.processing_count = processing_count
      end
    end

    private

    def processing_count
      Order.processing.count
    end

    def busyness
      processing_count.try do |count|
        (count <= 25)  ? BUSYNESS_EMPTY  :
        (count <= 50)  ? BUSYNESS_NORMAL :
        (count <= 100) ? BUSYNESS_JAM
                       : BUSYNESS_HALT
      end
    end
  end
end
