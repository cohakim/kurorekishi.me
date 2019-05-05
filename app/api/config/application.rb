require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module API
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true

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
