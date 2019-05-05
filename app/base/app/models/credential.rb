class Credential
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :consumer_key,    default: -> { configatron.twitter.consumer_key }
  attribute :consumer_secret, default: -> { configatron.twitter.consumer_secret }
  attribute :access_token
  attribute :access_token_secret

  def self.construct(access_token, access_token_secret)
    new(access_token: access_token, access_token_secret: access_token_secret)
  end
end
