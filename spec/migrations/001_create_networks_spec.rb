require_relative '../../db/migrate/001_create_networks'

describe CreateNetworks do
  # This code is making sure the database is set to a clean state
  before(:all) { DatabaseCleaner.strategy = :truncation }
  after(:all)  { DatabaseCleaner.strategy = :transaction }

  let(:previous_version) { 0 }
  let(:current_version) { 1 }

  before do
    # This rolls back the schema to the previous migration so we can test the current one
    # The migrate! method is defined in `spec/spec_helper.rb`
    migrate!(:down, previous_version)
    # Active Record caches some information on the class, so we're resetting it before and
    # after the test to make sure the class is in a clean state
    Network.reset_column_information
  end

  after do
    Network.reset_column_information
  end

  describe "#change" do
    it "creates a networks table with channel and call_letters columns" do
      # This runs the current migration
      migrate!(:up, current_version)
      expect(Network.columns_hash).to include({
        "channel" => have_attributes(type: :integer),
        "call_letters" => have_attributes(type: :string)
      })
    end
  end
end
