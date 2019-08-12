class CollectPolicy
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :collect_parameter, :tweet

  validate :validate_posted_before_logged_in,   if: -> { collect_parameter.signedin_at.present?      }
  validate :validate_posted_after_collect_from, if: -> { collect_parameter.collect_from.present?     }
  validate :validate_posted_before_collect_to,  if: -> { collect_parameter.collect_to.present?       }
  validate :validate_tweet_is_not_reply,        if: -> { collect_parameter.protect_reply.present?    }
  validate :validate_tweet_is_not_favorited,    if: -> { collect_parameter.protect_favorite.present? }

  alias :can_destroy? :valid?

  def initialize(collect_parameter:, tweet:)
    @collect_parameter = collect_parameter
    @tweet             = tweet
  end

  # ログイン前に投稿されたツイートであることを検証する
  def validate_posted_before_logged_in
    tweet.created_at < collect_parameter.signedin_at || errors.add(:base, 'posted_after_logged_in')
  end

  # 対象期間（開始）より後に投稿されたツイートであることを検証する
  def validate_posted_after_collect_from
    tweet.created_at >= collect_parameter.collect_from || errors.add(:base, 'posted_before_collect_from')
  end

  # 対象期間（終了）より前に投稿されたツイートであることを検証する
  def validate_posted_before_collect_to
    tweet.created_at < collect_parameter.collect_to || errors.add(:base, 'posted_after_collect_to')
  end

  # リプライツイートでないことを検証する
  def validate_tweet_is_not_reply
    tweet.reply? && errors.add(:base, 'tweet_is_reply')
  end

  # お気にいりされていないことを検証する
  def validate_tweet_is_not_favorited
      tweet.favorited? && errors.add(:base, 'tweet_is_favorited')
  end
end
