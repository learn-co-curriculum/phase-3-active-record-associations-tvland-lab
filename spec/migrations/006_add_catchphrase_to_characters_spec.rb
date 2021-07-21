require_relative '../../db/migrate/006_add_catchphrase_to_characters'

describe AddCatchphraseToCharacters do
  before(:all) { DatabaseCleaner.strategy = :truncation }
  after(:all)  { DatabaseCleaner.strategy = :transaction }

  let(:previous_version) { 5 }
  let(:current_version) { 6 }

  around do |example|
    migrate!(:down, previous_version)
    Character.reset_column_information
    example.run
    Character.reset_column_information
  end

  describe "#change" do
    it "updates the characters table to include a catchphrase column" do
      migrate!(:up, current_version)
      expect(Character.columns_hash).to include({
        "name" => have_attributes(type: :string),
        "actor_id" => have_attributes(type: :integer),
        "show_id" => have_attributes(type: :integer),
        "catchphrase" => have_attributes(type: :string)
      })
    end
  end

end
