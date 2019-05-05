Rails.application.config.middleware.use OmniAuth::Builder do
  force_login = Rails.env.development? ? false : true

  provider :twitter, configatron.twitter.consumer_key, configatron.twitter.consumer_secret, {
    path_prefix: '/cleaner/auth', authorize_params: { force_login: force_login }
  }
  OmniAuth.config.on_failure = SessionsController.action(:failure)
  OmniAuth.config.logger     = Rails.logger
end
