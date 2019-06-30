class OrderDecorator < Draper::Decorator
  include ActionView::Helpers::DateHelper

  delegate_all
  decorates_association :parameter

  def progression_bar_width
    return 0 if collect_count.zero?
    (destroy_count.fdiv(collect_count) * 100).to_i
  end

  def state_message
    if object.collecting?
      'ツイート取得中...'
    elsif object.cleaning?
      "#{destroy_count} / #{collect_count}"
    elsif object.completed?
      '完了!'
    elsif object.aborted?
      'ユーザによりキャンセルされました'
    elsif object.failed?
      'エラーにより強制終了されました'
    elsif object.expired?
      '期間内に完了しなかったため、強制終了されました'
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
