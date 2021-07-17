require_relative '../../db/migrate/006_add_catchphrase_to_characters'

describe AddCatchphraseToCharacters do
  let(:previous_version) { 5 }
  let(:target_version) { 6 }
  
  before do 
    migrate!(previous_version)
    Character.reset_column_information
  end

  describe "#change" do
    it "updates the characters table to include a catchphrase column" do
      migrate!(target_version)
      expect(Character.columns_hash).to include({
        "name" => have_attributes(type: :string),
        "actor_id" => have_attributes(type: :integer),
        "show_id" => have_attributes(type: :integer),
        "catchphrase" => have_attributes(type: :string)
      })
    end
  end
end
