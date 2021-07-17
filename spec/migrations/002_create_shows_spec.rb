require_relative '../../db/migrate/002_create_shows'

describe CreateShows do
  let(:previous_version) { 1 }
  let(:target_version) { 2 }
  
  before do 
    migrate!(previous_version)
    Show.reset_column_information
  end

  describe "#change" do
    it "creates a shows table with a name column" do
      migrate!(target_version)
      expect(Show.columns_hash).to include({
        "name" => have_attributes(type: :string)
      })
    end
  end
end
