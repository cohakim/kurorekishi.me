require 'sidekiq'
require 'sidekiq-unique-jobs'
require 'sidekiq/web'
require 'sidekiq_unique_jobs/web'

redis_config = YAML.load_file(Shared::Engine.root.join('config', 'redis.yml'))
redis        = "#{redis_config[Rails.env]}"

Sidekiq.configure_client do |config|
  config.redis = { url: redis }
end
