require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = Pathname.new(__dir__).join("../fixtures/vcr_cassettes")
  config.hook_into :webmock
  config.configure_rspec_metadata!
end
