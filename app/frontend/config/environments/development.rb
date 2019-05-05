Rails.application.configure do
  # class loading
  config.cache_classes                              = false
  config.eager_load                                 = false
  config.file_watcher                               = ActiveSupport::EventedFileUpdateChecker

  # error handling
  config.consider_all_requests_local                = true
  config.action_dispatch.show_exceptions            = true
  config.action_controller.allow_forgery_protection = true
  config.i18n.fallbacks                             = false

  # warning
  config.active_support.deprecation                 = :stderr
  config.active_record.verbose_query_logs           = true
  config.active_record.dump_schema_after_migration  = false

  # assets
  config.public_file_server.enabled                 = true

  # cacheing
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching        = true
    config.cache_store                              = :memory_store
  else
    config.action_controller.perform_caching        = false
    config.cache_store                              = :null_store
  end

  # loggoing
  config.log_level                                  = :debug
  config.log_tags                                   = [ :request_id ]
end
