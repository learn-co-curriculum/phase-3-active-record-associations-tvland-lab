require_relative '../../db/migrate/006_add_catchphrase_to_characters'

describe "AddCatchphraseToCharacters migration" do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  after(:all) do
    DatabaseCleaner.strategy = :transaction
  end

  it "updates the characters table to include a catchphrase column" do
    expect(ActiveRecord::Base.connection.table_exists?(:characters)).to be true

    columns = ActiveRecord::Base.connection.columns(:characters)
    column_names = columns.map(&:name)

    expect(column_names).to include("name", "actor_id", "show_id", "catchphrase")

    expect(columns.find { |c| c.name == "name" }.sql_type_metadata.type).to eq(:string)
    expect(columns.find { |c| c.name == "actor_id" }.sql_type_metadata.type).to eq(:integer)
    expect(columns.find { |c| c.name == "show_id" }.sql_type_metadata.type).to eq(:integer)
    expect(columns.find { |c| c.name == "catchphrase" }.sql_type_metadata.type).to eq(:string)
  end
end
