# TV Land ActiveRecord Associations Lab

## Objectives
1. Creating and modifying tables using ActiveRecord
2. Writing associations between models


## spec/actor_spec.rb

1. Build out the schema for the actors and characters table.
2. Actors should have a `first_name` and a `last_name`.
3. Characters should have a `name` and a `show_id`.
4. Associate the Actor model with the Character and Show model. Do any of the models need a foreign key?
5. Write the two methods `full_name` and `list_roles` that the spec requires. Write any helper methods that you need.

## spec/character_spec.rb

1. Add the column `catchphrase` to your character model.
2. Define the method `say_that_thing_you_say` and make the spec pass.

## spec/show_spec.rb
 
1. Create the neccesary associations between shows, networks, and characters.
2. Add all the attributes to the Show model that the spec requires.

## Active Record 5.x migration syntax update

***NOTE***: As of Active Record 5.x, we can no longer inherit directly from `ActiveRecord::Migration` and must instead specify which version of Active Record / Rails the migration was written for. If we were writing a migration for Active Record 5.1, we would inherit from `ActiveRecord::Migration[5.1]`. Don't worry too much about this until you get to the Rails section. Until then, if you encounter an error like this...
```
StandardError: Directly inheriting from ActiveRecord::Migration is not supported. Please specify the Rails release the migration was written for:

  class CreateDogs < ActiveRecord::Migration[4.2]
```
...simply add `[4.2]` to the end of `ActiveRecord::Migration`, exactly as the error message instructs.

## Resources
+ Rails Guide - [Active Record Associations](http://guides.rubyonrails.org/association_basics.html)
+ Api dock - [Active Record Associations](http://apidock.com/rails/ActiveRecord/Associations)
+ Rails Guide - [Active Record Migrations](http://edgeguides.rubyonrails.org/active_record_migrations.html)