require_relative '../../db/migrate/005_create_characters'

describe CreateCharacters do
  before(:all) { DatabaseCleaner.strategy = :truncation }
  after(:all)  { DatabaseCleaner.strategy = :transaction }

  let(:previous_version) { 4 }
  let(:current_version) { 5 }

  around do |example|
    migrate!(:down, previous_version)
    Character.reset_column_information
    example.run
    Character.reset_column_information
  end

  describe "#change" do
    it "creates an characters table with name, actor_id, and show_id columns" do
      migrate!(:up, current_version)
      expect(Character.columns_hash).to include({
        "name" => have_attributes(type: :string),
        "actor_id" => have_attributes(type: :integer),
        "show_id" => have_attributes(type: :integer)
      })
    end
  end

end
