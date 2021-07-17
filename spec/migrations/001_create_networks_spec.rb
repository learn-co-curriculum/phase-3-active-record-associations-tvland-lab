require_relative '../../db/migrate/001_create_networks'

describe CreateNetworks do
  let(:previous_version) { nil }
  let(:target_version) { 1 }
  
  before do 
    migrate!(previous_version)
    Network.reset_column_information
  end

  describe "#change" do
    it "creates a networks table with channel and call_letters columns" do
      migrate!(target_version)
      expect(Network.columns_hash).to include({
        "channel" => have_attributes(type: :integer),
        "call_letters" => have_attributes(type: :string)
      })
    end
  end
end
