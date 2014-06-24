require_relative 'spec_helper'

describe "Actor" do
  #TODO: implement the tests as described in the it blocks,
  #      and implement the class and migrations required to pass them

  # HINTS: look at show_spec.rb and network_spec.rb and character_spec.rb for guidance

  xit "has a first and last name" do
    # TODO set up the basic data model for actor
  end

  xit "has associated characters in an array" do
    # Hint: think about what migration you'll need to write so that an actor can have many characters.
    # Where will the association foreign key go?
    # TODO set up the appropriate association for characters and add characters through the array push
  end

  xit "can build its associated characters" do
    # TODO add a character to an actor with a build method
  end

  xit "can build its associated shows through its characters" do
    # TODO in one line, build a show and a character for this actor
  end

  xit "can list its full name" do
    # TODO create an instance method on actor called .full_name to return first and last name together
  end

  xit "can list all of its shows and characters" do
    # TODO create a list_roles method
    # TODO: build a method on actor that will return a string in the form of
    # character name - show name\n and test the results
  end
end
