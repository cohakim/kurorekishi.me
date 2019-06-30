class Credential < Dry::Struct
  attribute :consumer_key,        Types::Strict::String.default { configatron.twitter.consumer_key }
  attribute :consumer_secret,     Types::Strict::String.default { configatron.twitter.consumer_secret }
  attribute :access_token,        Types::Strict::String
  attribute :access_token_secret, Types::Strict::String
end
