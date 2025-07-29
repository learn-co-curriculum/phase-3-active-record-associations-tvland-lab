require_relative '../../db/migrate/002_create_shows'

describe "CreateShows migration" do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  after(:all) do
    DatabaseCleaner.strategy = :transaction
  end

  it "creates a shows table with name, day, season, and genre columns" do
    expect(ActiveRecord::Base.connection.table_exists?(:shows)).to be true

    columns = ActiveRecord::Base.connection.columns(:shows)
    column_names = columns.map(&:name)

    expect(column_names).to include("name", "day", "season", "genre")

    expect(columns.find { |c| c.name == "name" }.sql_type_metadata.type).to eq(:string)
    expect(columns.find { |c| c.name == "day" }.sql_type_metadata.type).to eq(:string)
    expect(columns.find { |c| c.name == "season" }.sql_type_metadata.type).to eq(:string)
    expect(columns.find { |c| c.name == "genre" }.sql_type_metadata.type).to eq(:string)
  end
end
