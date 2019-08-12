require 'sidekiq'
require 'sidekiq-unique-jobs'
require 'sidekiq-scheduler'

redis_config = YAML.load_file(Shared::Engine.root.join('config', 'redis.yml'))
redis        = "#{redis_config[Rails.env]}"
schedule     = YAML.load_file(Rails.root.join('config', 'scheduler.yml'))

Sidekiq.configure_server do |config|
  config.redis = { url: redis }
  config.average_scheduled_poll_interval = 3
  config.on(:startup) do
    Sidekiq.schedule = schedule
    Sidekiq::Scheduler.reload_schedule!
  end
end

Sidekiq.default_worker_options = {
  retry: 0,
  backtrace: false,
  unique: :until_executed,
  lock_ttl: 3.minutes,
  unique_args: ->(args) { [ args.first.except('job_id') ] }
}
