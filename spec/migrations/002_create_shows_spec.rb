require_relative '../../db/migrate/002_create_shows'

describe CreateShows do
  before(:all) { DatabaseCleaner.strategy = :truncation }
  after(:all)  { DatabaseCleaner.strategy = :transaction }

  let(:previous_version) { 1 }
  let(:current_version) { 2 }

  around do |example|
    migrate!(:down, previous_version)
    Show.reset_column_information
    example.run
    Show.reset_column_information
  end

  describe "#change" do
    it "creates a shows table with a name, day, season and genre column" do
      migrate!(:up, current_version)
      expect(Show.columns_hash).to include({
        "name" => have_attributes(type: :string),
        "day" => have_attributes(type: :string),
        "season" => have_attributes(type: :string),
        "genre" => have_attributes(type: :string)
      })
    end
  end

end
