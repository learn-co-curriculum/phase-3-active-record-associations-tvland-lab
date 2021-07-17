require_relative '../../db/migrate/005_create_characters'

describe CreateCharacters do
  let(:previous_version) { 3 }
  let(:target_version) { 4 }
  
  before do 
    migrate!(previous_version)
    Character.reset_column_information
  end

  describe "#change" do
    it "creates an characters table with name, actor_id, and show_id columns" do
      migrate!(target_version)
      expect(Character.columns_hash).to include({
        "name" => have_attributes(type: :string),
        "actor_id" => have_attributes(type: :integer),
        "show_id" => have_attributes(type: :integer)
      })
    end
  end
end
