require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = Rails.root.join('spec/fixtures/cassettes')
  config.hook_into :webmock
end
