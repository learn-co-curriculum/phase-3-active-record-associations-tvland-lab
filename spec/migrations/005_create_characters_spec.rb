require_relative '../../db/migrate/005_create_characters'

describe "CreateCharacters migration" do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  after(:all) do
    DatabaseCleaner.strategy = :transaction
  end

  it "creates a characters table with name, actor_id, and show_id columns" do
    expect(ActiveRecord::Base.connection.table_exists?(:characters)).to be true

    columns = ActiveRecord::Base.connection.columns(:characters)
    column_names = columns.map(&:name)

    expect(column_names).to include("name", "actor_id", "show_id")

    expect(columns.find { |c| c.name == "name" }.sql_type_metadata.type).to eq(:string)
    expect(columns.find { |c| c.name == "actor_id" }.sql_type_metadata.type).to eq(:integer)
    expect(columns.find { |c| c.name == "show_id" }.sql_type_metadata.type).to eq(:integer)
  end
end
