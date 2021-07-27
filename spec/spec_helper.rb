ENV['RAILS_ENV'] ||= 'test'
require 'active_record'
ActiveRecord::Base.logger = Logger.new($stdout) if ENV['DEBUG']

$LOAD_PATH.unshift File.expand_path("#{__dir__}/../app")

# load rails/redmine
if ENV['REDMINE_PATH']
  require File.expand_path('config/environment', ENV['REDMINE_PATH'])
else
  require File.expand_path('../../../config/environment', __dir__)
end

# test gems
require 'rspec/rails'

# require 'rspec/autorun'
require 'rspec/mocks'
require 'rspec/mocks/standalone'

# re-use the redmine provided factory elements and helpers
if ENV['REDMINE_PATH']
  require File.expand_path('test/object_helpers', ENV['REDMINE_PATH'])
else
  require File.expand_path('../../../test/object_helpers', __dir__)
end

# rspec base config
RSpec.configure do |config|
  config.fail_fast = false
  config.mock_with :rspec
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.fixture_path = "#{::Rails.root}/test/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  # Configure expect to only accept the "expect" syntax not "should"
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
