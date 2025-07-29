require_relative '../../db/migrate/004_create_actors'

describe "CreateActors migration" do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  after(:all) do
    DatabaseCleaner.strategy = :transaction
  end

  it "creates an actors table with first_name and last_name columns" do
    expect(ActiveRecord::Base.connection.table_exists?(:actors)).to be true

    columns = ActiveRecord::Base.connection.columns(:actors)
    column_names = columns.map(&:name)

    expect(column_names).to include("first_name", "last_name")

    expect(columns.find { |c| c.name == "first_name" }.sql_type_metadata.type).to eq(:string)
    expect(columns.find { |c| c.name == "last_name" }.sql_type_metadata.type).to eq(:string)
  end
end
