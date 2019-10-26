Rails.application.config.middleware.use OmniAuth::Builder do
  force_login = Rails.env.development? ? false : true

  provider :twitter, configatron.twitter.consumer_key, configatron.twitter.consumer_secret, {
    path_prefix: '/cleaner/v1/auth',
    authorize_params: {
      force_login: force_login,
      callback_url: '/cleaner/v1/auth/twitter/callback'
    }
  }
  OmniAuth.config.on_failure = SessionsController.action(:failure)
  OmniAuth.config.logger     = Rails.logger
end
