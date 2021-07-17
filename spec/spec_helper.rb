ENV['RACK_ENV'] = 'test'
require_relative "../config/environment"
require "sinatra/activerecord/rake"

RSpec.configure do |config|
  # Database setup

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  
  config.shared_context_metadata_behavior = :apply_to_host_groups
end

def migrate!(direction, version)
  migrations_paths = ActiveRecord::Migrator.migrations_paths
  migrations = ActiveRecord::MigrationContext.new(migrations_paths, ActiveRecord::SchemaMigration).migrations
  
  ActiveRecord::Migration.suppress_messages do
    ActiveRecord::Migrator.new(direction, migrations, ActiveRecord::SchemaMigration, version).migrate
  end
end
