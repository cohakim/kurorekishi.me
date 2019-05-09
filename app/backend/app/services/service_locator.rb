class ServiceLocator
  @@services = {}

  def self.register(service_name, context, klass)
    @@services.store([service_name, context], klass)
  end

  def self.resolve(service_name, context = :none)
    @@services.fetch([service_name, context])
  end

  register :collect_service, :timeline, CollectFromTimelineService
  register :collect_service, :archive,  CollectFromArchiveService
  register :destroy_service, :none,     DestroyService
end
