require "pry"

describe Actor do
  let(:emilia) { Actor.first }

  before do
    emilia = Actor.create(first_name: "Emilia", last_name: "Clarke")
    got = Show.create(name: "Game of Thrones")
    Character.create(name: "Khaleesi", actor_id: emilia.id, show_id: got.id)
  end

  it "has a first and last name" do
    expect(emilia).to have_attributes(first_name: "Emilia", last_name: "Clarke")
  end

  describe "#characters" do
    it "returns a list of characters associated with the actor" do
      khaleesi = Character.find_by(name: "Khaleesi")
      expect(emilia.characters).to include(khaleesi)
    end
  end

  describe "#shows" do
    it "returns the shows associated with the actor through their characters" do
      got = Show.find_by(name: "Game of Thrones")
      expect(emilia.shows).to include(got)
    end
  end

  describe "#full_name" do
    it "returns the actor's full name" do
      expect(emilia.full_name).to eq("Emilia Clarke")
    end
  end

  describe "#list_roles" do
    it "returns a list of roles for the actor using the character name and show name" do
      expect(emilia.list_roles).to include("Khaleesi - Game of Thrones")
    end
  end

end
