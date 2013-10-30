require_relative 'spec_helper'

describe Show do
  let(:show) {Show.new}

  it "has data attributes" do
    #TODO: You'll need to create a new migration to add
    #the necessary columns to the shows table
    Show.create(:name => "Community", :day => "Thursday", :season => "Winter")
    community = Show.find_by(:name => "Community")
    community.day.should eq("Thursday")
    community.season.should eq("Winter")
  end

  it "has many characters" do
    #TODO: we need to associate characters to shows. for reference
    #look how shows are associated with networks
    #pay attention to both the model and the migrations
    show.name = "The Simpsons"
    characters = [
      Character.new(:name => "Ralph Wiggum"),
      Character.new(:name => "Homer Simpson"),
      Character.new(:name => "Apu Nahasapeemapetilon")
    ]
    show.characters << characters
    show.save
    show.characters.count.should eq(3)
    show.characters.collect { |s| s.name }.should include("Homer Simpson")
  end

  it "should have a genre" do
    #TODO: you'll need to add yet another new field to shows here
    show.name = "Gilmore Girls"
    show.genre = "Dramedy"
    show.save
    dramedy = Show.find_by(:genre => "Dramedy").first
    dramedy.name.should eq("Gilmore Girls")
  end
end
