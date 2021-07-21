describe Character do

  it "has a first and last name" do
    jerry = Character.create(name: 'Jerry')
    expect(jerry.name).to eq("Jerry")
  end

  it "has a catchphrase" do
    urkel = Character.create(name: "Steve Urkel", catchphrase: "Did I do that?")
    expect(urkel.catchphrase).to eq("Did I do that?")
  end

  describe "#actor" do
    it "returns the actor that the character belongs to" do
      danny_pudi = Actor.create(first_name: "Danny", last_name: "Pudi")
      abed = Character.create(name:'Abed', actor_id: danny_pudi.id)
      expect(abed.actor).to eq(danny_pudi)
    end
  end

  describe "#show" do
    it "returns the show that the character belongs to" do
      frasier = Show.create(name: "Frasier")
      niles = Character.create(name: "Niles Crane", show_id: frasier.id)
      expect(niles.show).to eq(frasier)
    end

    it "can be used to build its associated show" do
      jules_cobb = Character.new(name: "Jules Cobb")
      jules_cobb.build_show(name: "Cougar Town")
      expect(jules_cobb.show.name).to eq("Cougar Town")
    end
  end

  describe "#say_that_thing_you_say" do
    it "returns a string with the character's name and catchphrase" do
      urkel = Character.create(name: "Steve Urkel", catchphrase: "Did I do that?")
      expect(urkel.say_that_thing_you_say).to eq("Steve Urkel always says: Did I do that?")
    end
  end

end
