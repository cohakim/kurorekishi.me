require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'csv'

Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true

    # paths
    config.paths.add 'config/database', with: Shared::Engine.root.join('config', 'database.yml')
    config.active_storage.service_configurations = begin
      config_file = Pathname.new(Shared::Engine.root.join("config/storage.yml"))
      YAML.load(ERB.new(config_file.read).result) || {}
    end

    # locales
    config.i18n.load_path                 += Dir[
      Shared::Engine.root.join('config', 'locales', '**', '*.{rb,yml}'),
      Rails.root.join('config', 'locales', '**', '*.{rb,yml}'),
    ]
    config.i18n.available_locales         = %i(ja en)
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale            = :ja
    config.time_zone                      = 'Tokyo'

    # logging
    config.logger = ActiveSupport::Logger.new(STDOUT)

    # active_job
    config.active_job.queue_adapter = :sidekiq
    config.active_storage.service = :amazon
  end
end
