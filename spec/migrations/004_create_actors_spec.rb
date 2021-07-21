require_relative '../../db/migrate/004_create_actors'

describe CreateActors do
  before(:all) { DatabaseCleaner.strategy = :truncation }
  after(:all)  { DatabaseCleaner.strategy = :transaction }

  let(:previous_version) { 3 }
  let(:current_version) { 4 }

  around do |example|
    migrate!(:down, previous_version)
    Actor.reset_column_information
    example.run
    Actor.reset_column_information
  end

  describe "#change" do
    it "creates an actors table with first_name and last_name columns" do
      migrate!(:up, current_version)
      expect(Actor.columns_hash).to include({
        "first_name" => have_attributes(type: :string),
        "last_name" => have_attributes(type: :string)
      })
    end
  end

end
