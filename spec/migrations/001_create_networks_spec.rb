require_relative '../../db/migrate/001_create_networks'

describe "CreateNetworks migration" do
  before(:all) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  after(:all) do
    DatabaseCleaner.strategy = :transaction
  end

  it "creates a networks table with channel and call_letters columns" do
    expect(ActiveRecord::Base.connection.table_exists?(:networks)).to be true

    columns = ActiveRecord::Base.connection.columns(:networks)

    column_names = columns.map(&:name)
    expect(column_names).to include("channel", "call_letters")

    channel_column = columns.find { |col| col.name == "channel" }
    call_letters_column = columns.find { |col| col.name == "call_letters" }

    expect(channel_column.sql_type_metadata.type).to eq(:integer)
    expect(call_letters_column.sql_type_metadata.type).to eq(:string)
  end
end
