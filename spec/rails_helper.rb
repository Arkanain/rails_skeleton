require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

# Load all helpers for specs
Dir[Rails.root.join("spec/support/**/*.rb")].each(&method(:require))

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Fixtures location
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # Remove fixtures after each spec
  config.use_transactional_fixtures = true

  # Set spec type by folder name
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  # FactoryBot methods
  config.include FactoryBot::Syntax::Methods

  # DatabaseCleaner
  DatabaseCleanerConfig.setup(config)

  # Seeds config
  Kernel.srand(config.seed)
  config.order = "random"
end
