class MagicalTwitterClient
  attr_reader :credentials

  REQUEST_URL_DESTROY = "https://api.twitter.com/1.1/statuses/destroy/%{status_id}.json"

  def initialize(credentials)
    @credentials = credentials
  end

  def retrieve_timeline
    options = {
      count:       200,
      include_rts: true,
      trim_user:   true,
    }
    16.times.each do
      user_timeline = rest_client.user_timeline(options)
      break if user_timeline.empty?
      user_timeline.each do |tweet|
        yield tweet
      end
      options.merge!({ max_id: user_timeline.last.id - 1 })
    end
  end

  def destroy_status(status_id)
    oauth_client.post(REQUEST_URL_DESTROY % { status_id: status_id })
  end

  def post_status(message)
    rest_client.update(message)
  end

  private

  def oauth_client
    consumer = OAuth::Consumer.new(
      credentials.consumer_key,
      credentials.consumer_secret,
      site:'https://api.twitter.com/'
    )
    @oauth_client ||= OAuth::AccessToken.new(
      consumer,
      credentials.access_token,
      credentials.access_token_secret
    )
  end

  def rest_client
    @rest_client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = credentials.consumer_key
      config.consumer_secret     = credentials.consumer_secret
      config.access_token        = credentials.access_token
      config.access_token_secret = credentials.access_token_secret
    end
  end
end
