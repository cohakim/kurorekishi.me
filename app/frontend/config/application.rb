require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Frontend
  class Application < Rails::Application
    config.load_defaults 5.2

    # paths
    config.paths.add 'config/database', with: Base::Engine.root.join('config', 'database.yml')

    # locales
    config.i18n.available_locales         = %i(ja en)
    config.i18n.enforce_available_locales = true
    config.i18n.default_locale            = :ja
    config.time_zone                      = 'Tokyo'

    # logging
    config.logger = ActiveSupport::Logger.new(STDOUT)
  end
end
