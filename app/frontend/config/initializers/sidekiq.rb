require 'sidekiq'
require 'sidekiq-unique-jobs'
require 'sidekiq/web'
require 'sidekiq_unique_jobs/web'

yaml         = Pathname.new(Shared::Engine.root.join('config', 'redis.yml'))
redis_config = YAML.load(ERB.new(yaml.read).result)
redis        = "#{redis_config[Rails.env]}"

Sidekiq.configure_client do |config|
  config.redis = { url: redis }
end
