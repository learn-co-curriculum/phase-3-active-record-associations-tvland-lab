require_relative '../../db/migrate/003_add_network_to_shows'

describe "AddNetworkToShows migration" do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  after(:all) do
    DatabaseCleaner.strategy = :transaction
  end

  it "adds a network_id column to the shows table" do
    expect(ActiveRecord::Base.connection.table_exists?(:shows)).to be true

    columns = ActiveRecord::Base.connection.columns(:shows)
    column_names = columns.map(&:name)

    expect(column_names).to include("network_id", "name")

    network_id_column = columns.find { |c| c.name == "network_id" }
    name_column = columns.find { |c| c.name == "name" }

    expect(network_id_column.sql_type_metadata.type).to eq(:integer)
    expect(name_column.sql_type_metadata.type).to eq(:string)
  end
end
