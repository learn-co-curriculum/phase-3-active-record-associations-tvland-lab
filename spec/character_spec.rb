require_relative 'spec_helper'

describe Character do

  it "has data attributes" do
    Character.create(:name => "Abed", :actor => "Danny Pudi")
    Character.find_by(:name => "Abed").actor.should eq("Danny Pudi")
  end

  it "belongs to a show" do
    frasier = Show.new(:name => "Frasier")
    niles = Character.new(:name => "Niles Crane")
    niles.show = frasier
    niles.save
    #reload frasier show from db
    frasier.reload
    frasier.characters.should include(niles)
    niles.show.should eq(frasier)
  end

  it "has a catchphrase" do
    urkel = Character.new(:name => "Steve Urkel")
    urkel.catchphrase = "Did I do that?"
    urkel.save
    Character.find_by(:id => urkel.id).catchphrase.should eq(urkel.catchphrase)

    #TODO: make a method in the model to say his name and catchphrase
    #remember the model is yours do do with as you please, you 
    #are free to add methods that perform actions on the model's data
    urkel.say_that_thing_you_say.should eq("#{urkel.name} always says: #{urkel.catchphrase}")

  end
end
