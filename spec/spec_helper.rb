ENV['RACK_ENV'] ||= 'test'

require_relative "../config/environment"
require "sinatra/activerecord/rake"
require "rake"

# Define environment task for Rake to avoid whining
Rake::Task.define_task(:environment)

# Migrate the test database before running the suite
Rake::Task["db:migrate"].reenable
Rake::Task["db:migrate"].invoke

RSpec.configure do |config|
  # Clean DB before suite runs
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end

  # Wrap each test in a transaction
  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # RSpec expectations
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # RSpec mocks
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # Shared context metadata behavior
  config.shared_context_metadata_behavior = :apply_to_host_groups
end
