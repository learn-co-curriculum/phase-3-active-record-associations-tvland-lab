describe Show do

  it "has a name, day, season and genre" do
    community = Show.create(name: "Community", day: "Thursday", season: "Winter", genre: "Comedy")
    expect(community).to have_attributes(name: "Community", day: "Thursday", season: "Winter", genre: "Comedy")
  end

  describe "#characters" do
    it "returns the characters associated with the show" do
      simpsons = Show.create(name: "The Simpsons")
      Character.create(name: "Ralph Wiggum", show_id: simpsons.id)
      Character.create(name: "Homer Simpson", show_id: simpsons.id)
      Character.create(name: "Apu Nahasapeemapetilon", show_id: simpsons.id)
      expect(simpsons.characters.count).to eq(3)
    end

    it "can be used to build its characters" do
      show = Show.create(name: "Happy Endings")
      show.characters.build(name: "Penny")
      show.save
      expect(show.characters.count).to eq(1)
    end
  end

  describe "#network" do
    it "returns the network that the show belongs to" do
      show = Show.create(name: "Community", day: "Thursday", season: "Winter", genre: "Comedy")
      network = show.build_network(call_letters: "NBC")
      expect(show.network).to eq(network)
    end
  end

  describe "#actors_list" do
    it "returns a list of the full names of each actor associated with the show" do
      show = Show.create(name: "The Walking Dead")
      andrew = Actor.create(first_name: "Andrew", last_name: "Lincoln")
      Character.create(name: "Rick Grimes", show_id: show.id, actor_id: andrew.id)

      expect(show.actors_list).to include('Andrew Lincoln')
    end
  end

end
