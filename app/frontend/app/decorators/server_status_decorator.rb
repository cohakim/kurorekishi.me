module ServerStatusDecorator
  def message_for_busyness
    case busyness
    when ServerStatus::BUSYNESS_EMPTY
      '快適'
    when ServerStatus::BUSYNESS_NORMAL
      '普通'
    when ServerStatus::BUSYNESS_JAM
      '混雑'
    when ServerStatus::BUSYNESS_HALT
      'メンテ中'
    end
  end
end
