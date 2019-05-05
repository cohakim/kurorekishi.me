if defined? Bugsnag
  Bugsnag.configure do |config|
    config.api_key = configatron.bugsnag.api_key
    config.notify_release_stages = ['production']
  end
end
