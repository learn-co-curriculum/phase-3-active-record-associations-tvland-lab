require_relative 'spec_helper'

describe "Actor" do
  #TODO: implement the tests as described in the it blocks,
  #      and implement the class and migrations required to pass them

  # HINTS: look at show_spec.rb and network_spec.rb and character_spec.rb for guidance

  it "has a first and last name" do
    Actor.create(:first_name => "Keanu", :last_name => "Reeves")
    expect(Actor.find_by(:first_name => "Keanu").last_name).to eq("Reeves")
  end

  it "has associated characters in an array" do
    neo = Character.create(:name => "Neo")
    keanu = Actor.create(:first_name => "Keanu", :last_name => "Reeves")
    keanu.characters << neo
    neo.reload
    expect(keanu.characters).to include(neo)
    expect(neo.actor).to eq(keanu)
  end

  it "can build its associated characters" do
    alan_rickman = Actor.new(:first_name => "Alan", :last_name => "Rickman")
    alan_rickman.characters.build(:name => "Severus Snape")
    expect(alan_rickman.characters.first.name).to eq("Severus Snape")
  end

  it "can build its associated shows through its characters" do
    tina_fey = Actor.new(:first_name => "Tina", :last_name => "Fey")
    tina_fey.characters.build(:name => "Liz Lemon").build_show(:name => "30 Rock")
    characters = tina_fey.characters
    expect(characters.first.name).to eq("Liz Lemon")
    expect(characters.first.show.name).to eq("30 Rock")
  end

  it "can list its full name" do
    keanu = Actor.create(:first_name => "Keanu", :last_name => "Reeves")
    expect(keanu.full_name).to eq("#{keanu.first_name} #{keanu.last_name}")
  end

  it "can list all of its shows and characters" do
    tina_fey = Actor.create(:first_name => "Tina", :last_name => "Fey")
    tina_fey.characters.build(:name => "Liz Lemon").build_show(:name => "30 Rock")
    tina_fey.characters.build(:name => "Herself").build_show(:name => "SNL")
    tina_fey.save
    expect(tina_fey.list_roles).to include("Herself - SNL")
  end
end
