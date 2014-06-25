require_relative 'spec_helper'

describe "Actor" do
  let(:tom_hanks) do
    Actor.create(first_name: "Tom", last_name: "Hanks")
  end

  it "has a first and last name" do
    expect(Actor.find_by(first_name: tom_hanks.first_name).first_name).to eq("Tom")
  end

  it "has associated characters in an array" do
    josh = Character.create(name: "Josh")
    tom_hanks.characters << josh
    expect(tom_hanks.characters).to include(Character.first)
  end

  it "can build its associated characters" do
    tom_hanks.characters.build(name: "Forrest Gump").save
    expect(tom_hanks.characters).to include(Character.find_by(name: "Forrest Gump"))
  end

  it "can build its associated shows through its characters" do
    tom_hanks.characters.build(name: "The Guy Who Saved Private Ryan").
      build_show(name: "Saving Private Ryan")
    tom_hanks.save

    expect(tom_hanks.shows.first.name).to eq("Saving Private Ryan")
  end

  it "can list its full name" do
    expect(tom_hanks.full_name).to eq("Tom Hanks")
  end

  it "can list all of its shows and characters" do
    tom_hanks.characters.build(name: "Josh").build_show(name: "Big")
    tom_hanks.characters.build(name: "Forrest Gump").build_show(name: "Forrest Gump")
    tom_hanks.characters.build(name: "Lost Dude Who Gets Forgotten").build_show(name: "Castaway")
    tom_hanks.save

    tom_roles = <<-ROLES
Josh - Big
Forrest Gump - Forrest Gump
Lost Dude Who Gets Forgotten - Castaway
    ROLES

    expect(tom_hanks.list_roles).to eq(tom_roles)
  end
end