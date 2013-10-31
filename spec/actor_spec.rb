require_relative 'spec_helper'

describe "Actor" do
  #TODO: implement the tests as described in the it blocks,
  #      and implement the class and migrations required to pass them

  # HINTS: look at show_spec.rb and network_spec.rb and character_spec.rb for guidance

  it "has a first and last name" do
    pending "set up the basic data model for actor"
  end

  it "has associated characters in an array" do
    # Hint: think about what migration you'll need to write so that an actor can have many characters.
    # Where will the association foreign key go?
    pending "set up the appropriate association for characters and add characters through the array push"
  end

  it "can build its associated characters" do
    pending "add a character to an actor with a build method"
  end

  it "can build its associated shows through its characters" do
    pending "in one line, build a show and a character for this actor"
  end

  it "can list its full name" do
    pending "create an instance method on actor called .full_name to return first and last name together"
  end

  it "can list all of its shows and characters" do
    pending "create a list_roles method"
    # TODO: build a method on actor that will return a string in the form of
    # character name - show name\n and test the results
  end
end
