require_relative '../../db/migrate/001_create_networks'

describe CreateNetworks do
  before(:all) { DatabaseCleaner.strategy = :truncation }
  after(:all)  { DatabaseCleaner.strategy = :transaction }

  let(:previous_version) { 0 }
  let(:current_version) { 1 }

  before do
    migrate!(:down, previous_version)
    Network.reset_column_information
  end

  after do
    Network.reset_column_information
  end

  describe "#change" do
    it "creates a networks table with channel and call_letters columns" do
      migrate!(:up, current_version)
      expect(Network.columns_hash).to include({
        "channel" => have_attributes(type: :integer),
        "call_letters" => have_attributes(type: :string)
      })
    end
  end
end
