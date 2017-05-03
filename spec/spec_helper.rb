require 'bundler/setup'
require 'data_hoover'

ENV['SEGMENT_KEY'] = 'FAKE_KEY'

RSpec.configure do |config|
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
