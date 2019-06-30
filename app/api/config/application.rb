require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module API
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true

    # paths
    config.active_storage.service_configurations = begin
      config_file = Pathname.new(Shared::Engine.root.join("config/storage.yml"))
      YAML.load(ERB.new(config_file.read).result) || {}
    end

    # locales
    config.i18n.available_locales         = %i(ja en)
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale            = :ja
    config.time_zone                      = 'Tokyo'

    # logging
    config.logger = ActiveSupport::Logger.new(STDOUT)
  end
end
