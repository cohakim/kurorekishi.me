$:.push File.expand_path("lib", __dir__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shared"
  s.version     = "0.1.0"
  s.authors     = ["cohakim"]
  s.email       = ["cohakim@gmail.com"]
  s.homepage    = ""
  s.summary     = ""
  s.description = ""
  s.license     = ""

  s.files = Dir["{app,config,db,lib}/**/*"]

  s.add_dependency 'rails', '~> 5.2.2'
end
