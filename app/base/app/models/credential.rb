class Credential
  attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret

  def initialize(attributes)
    @access_token = attributes[:access_token]
    @access_token_secret = attributes[:access_token_secret]
  end

  def consumer_key
    configatron.twitter.consumer_key
  end

  def consumer_secret
    configatron.twitter.consumer_secret
  end

  def self.construct(access_token, access_token_secret)
    new(access_token: access_token, access_token_secret: access_token_secret)
  end
end
