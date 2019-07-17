require_relative 'spec_helper'

describe "Actor" do
  let(:actor) {Actor.new}

  it "has a first and last name" do
    actor = Actor.create(:first_name => "Emilia", :last_name => "Clarke")

    expect(actor.first_name).to eq("Emilia")
    expect(actor.last_name).to eq("Clarke")
  end

  it "has associated characters in an array" do
    emilia = Actor.new(:first_name => "Emilia", :last_name => "Clarke")
    khaleesi = Character.new(:name => "Khaleesi")
    khaleesi.actor = emilia
    khaleesi.save

    khaleesi.reload
    expect(emilia.characters).to include(khaleesi)
    expect(khaleesi.actor).to eq(emilia)
  end

  it "can build its associated characters" do
    emilia = Actor.new(:first_name => "Emilia", :last_name => "Clarke")
    khaleesi = Character.new(:name => "Khaleesi")
    khaleesi.actor = emilia
    khaleesi.save

    khaleesi.reload
    expect(emilia.characters.first.name).to eq("Khaleesi")
  end

  it "can build its associated shows through its characters" do
    emilia = Actor.new(:first_name => "Emilia", :last_name => "Clarke")
    khaleesi = Character.new(:name => "Khaleesi")
    khaleesi.actor = emilia
    got = Show.new(:name => "Game of Thrones")
    khaleesi.show = got
    khaleesi.save

    khaleesi.reload
    expect(khaleesi.show.name).to eq("Game of Thrones")
  end

  it "can list its full name" do
    emilia = Actor.new(:first_name => "Emilia", :last_name => "Clarke")
    emilia.save

    emilia.reload
    expect(emilia.full_name).to eq("Emilia Clarke")
  end

  it "can list all of its shows and characters" do
    emilia = Actor.new(:first_name => "Emilia", :last_name => "Clarke")
    khaleesi = Character.new(:name => "Khaleesi")
    khaleesi.actor = emilia
    got = Show.new(:name => "Game of Thrones")
    khaleesi.show = got
    khaleesi.save

    khaleesi.reload
    expect(emilia.list_roles).to include("Khaleesi - Game of Thrones")
  end
end
