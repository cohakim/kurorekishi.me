require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Frontend
  class Application < Rails::Application
    config.load_defaults 5.2

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
  end
end
