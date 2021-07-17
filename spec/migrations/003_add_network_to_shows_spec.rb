require_relative '../../db/migrate/003_add_network_to_shows'

describe AddNetworkToShows do
  let(:previous_version) { 2 }
  let(:target_version) { 3 }
  
  before do 
    migrate!(previous_version)
    Show.reset_column_information
  end

  describe "#change" do
    it "updates the shows table to include a network_id column" do
      migrate!(target_version)
      expect(Show.columns_hash).to include({
        "name" => have_attributes(type: :string),
        "network_id" => have_attributes(type: :integer)
      })
    end
  end
end
