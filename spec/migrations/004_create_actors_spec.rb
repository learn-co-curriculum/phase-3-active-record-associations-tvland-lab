require_relative '../../db/migrate/004_create_actors'

describe CreateActors do
  let(:previous_version) { 3 }
  let(:target_version) { 4 }
  
  before do 
    migrate!(previous_version)
    Actor.reset_column_information
  end

  describe "#change" do
    it "creates an actors table with first_name and last_name columns" do
      migrate!(target_version)
      expect(Actor.columns_hash).to include({
        "first_name" => have_attributes(type: :string),
        "last_name" => have_attributes(type: :string)
      })
    end
  end
end
