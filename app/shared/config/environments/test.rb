Rails.application.configure do
  config.require_master_key = true

  # class loading
  config.cache_classes                              = true
  config.eager_load                                 = false
  config.file_watcher                               = ActiveSupport::EventedFileUpdateChecker

  # error handling
  config.consider_all_requests_local                = true
  config.action_dispatch.show_exceptions            = false
  config.action_controller.allow_forgery_protection = false
  config.i18n.fallbacks                             = [I18n.default_locale]

  # warning
  config.active_support.deprecation                 = :stderr
  config.active_record.verbose_query_logs           = false
  config.active_record.dump_schema_after_migration  = false

  # assets
  config.public_file_server.enabled                 = true

  # cacheing
  config.action_controller.perform_caching          = false
  config.cache_store                                = :null_store

  # loggoing
  config.log_level                                  = :debug
  config.log_tags                                   = [ :request_id ]
end
