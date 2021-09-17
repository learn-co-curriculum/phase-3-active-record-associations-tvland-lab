# Active Record TV Land Lab

## Learning Goals

- Create and modify tables using Active Record migrations
- Build associations between models using Active Record macros

## Introduction

In this lab, we'll be working with a TV show domain model. We will have a show,
network, and character model. They will be associated in the following way:

- An actor has many characters and has many shows through characters.
- A character belongs to an actor and belongs to a show.
- A show has many characters and has many actors through characters.

Here's what the completed ERD will look like after you've created the additional
migrations:

![TVLand ERD](https://curriculum-content.s3.amazonaws.com/phase-3/active-record-associations-tvland-lab/tvland-erd.png)

We've given you a few migrations in the `db/migrate` directory to create the
networks and shows table, but you'll have to add additional tables and modify
these existing tables as per the guidelines below.

## Instructions

This lab is test-driven, so run `learn test` to see what you need to work on.
Start by completing the migrations. The first three migration files are
complete. You only need to work on the `004`, `005` and `006` migrations.

Then, work on building out methods in the classes. Make sure to use the Active Record
association macros like `has_many` and `belongs_to`. Remember, using these macros
creates **instance methods** on your classes, so to pass some of the tests, the macros
will be enough! You'll also have to write out some custom methods as well.

### Migrations

#### 004_create_actors

Write a migration to create the `actors` table. An actor should have a
`first_name` and a `last_name` as strings.

#### 005_create_characters

Write a migration to create the `characters` table. A character should have a
`name` (string), `actor_id` (integer), and a `show_id` (integer).

A character will belong to a show (the show migration is already provided) and
an actor, and we'll keep track of this relationship with these database table
columns.

#### 006_add_catchphrase_to_characters

Write a migration that adds the column `catchphrase` as a string to your
`characters` table.

### Model Methods

#### Character

- `#actor`: should return the actor instance this character belongs to.
  **Hint**: is there an association macro you can use to create this method?
- `#show`: should return the show instance this character belongs to. **Hint**:
  is there an association macro you can use to create this method?
- `#say_that_thing_you_say`: Define a method in the `Character` class,
  `#say_that_thing_you_say`, using a given character's catchphrase. Using Tyrion
  as an example again, the returned string should look like the following:

  ```ruby
  tyrion.catchphrase = 'A Lannister always pays his debts'
  tyrion.say_that_thing_you_say
  #=> 'Tyrion Lannister always says: A Lannister always pays his debts'
  ```

#### Actor

- `#characters`: an actor has many characters, so write code that creates an
  instance method that will return all the characters that the actor has played.
  **Hint**: is there an association macro you can use to create this method?
- `#shows`: an actor should have many characters and many shows through
  characters. Write code that creates an instance method that returns all the
  shows for the actor. **Hint**: is there an association macro you can use to
  create this method?
- `#full_name`: Write a method in the `Actor` class, `#full_name`, that returns
  the first and last name of an actor.
- `#list_roles`: Write a method in the `Actor` class, `#list_roles`, that lists
  all of the characters that actor has alongside the show that the character is
  in.

  So, for instance:

  ```ruby
  peter = Actor.create(first_name: "Peter", last_name: "Dinklage")
  thrones = Show.create(name: "Game of Thrones")
  tyrion = Character.create(name: "Tyrion Lannister", actor_id: peter.id, show_id: thrones.id)

  peter.list_roles
  # ['Tyrion Lannister - Game of Thrones']
  ```

  Notice that when we run `peter.list_roles`, we get an Array containing a
  string with both the character and the show.

#### Show

- `#characters`: should return a list of all the character instances associated with
  the show.
- `#network`: should return the network instance this show belongs to
- `#actors_list`: Define a method in the `Show` class called `#actors_list` that
  returns an Array of the full names of each actor associated with a show.
  Remember, a show should have many actors through characters. **Hint**: it may
  help to use another association macro to access the actors for the show.

#### Network

- `#shows`: should return a list of all the show instances associated with
  the network.
- `#sorry`: returns a string "We're sorry about passing on John Mulaney's
  pilot".

## Resources

- [Active Record Associations](http://guides.rubyonrails.org/association_basics.html)
- [API dock - Active Record Associations](https://apidock.com/rails/ActiveRecord/Associations/ClassMethods)
- [Active Record Migrations](https://guides.rubyonrails.org/active_record_migrations.html)
