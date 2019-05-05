module Base
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
      g.template_engine false
      g.system_tests    false
      g.test_framework  false
    end
  end
end
