ENV['RAILS_ENV'] ||= 'test'
require 'rspec/rails'
require_relative 'spec_helper'

################################################################################
Dir[Shared::Engine.root.join('spec/support/**/*.rb')].each { |f| require f }
FactoryBot.definition_file_paths << Shared::Engine.root.join('spec/factories')
FactoryBot.find_definitions

################################################################################
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!
  config.infer_base_class_for_anonymous_controllers = false

  config.include FactoryBot::Syntax::Methods
end
