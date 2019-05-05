class OrderDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper

  delegate_all

  def progression_bar_width
    return 0 if collect_count.zero?
    (destroy_count.fdiv(collect_count) * 100).to_i
  end

  def state_message
    if processing?
      case aasm(:progression).current_state
      when :collecting
        'ツイート取得中...'
      when :cleaning
        "#{destroy_count} / #{collect_count}"
      end
    elsif confirming?
      case aasm(:progression).current_state
      when :completed
        '完了!'
      when :aborted
        'ユーザによりキャンセルされました'
      when :failed
        'エラーにより強制終了されました'
      when :expired
        '期間内に完了しなかったため、強制終了されました'
      end
    end
  end

  def state_completion_message
    case aasm(:progression).current_state
    when :completed
      '正常に完了しました'
    when :failed
      'エラーにより強制終了されました'
    when :aborted
      'ユーザによりキャンセルされました'
    when :expired
      '期間内に完了しなかったため、強制終了されました'
    end
  end

  def processing_time
    distance_of_time_in_words(created_at, processed_at)
  end
end
