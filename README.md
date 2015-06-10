# TV Land ActiveRecord Associations Lab

## Objectives
1. Creating and modifying tables using ActiveRecord
2. Writing associations between models


## spec/actor_spec.rb

1. Build out the schema for the actors and characters table.
2. Actors should have a first and a lastname.
3. Characters should have a name and a show_id.
4. Associate the actor model with the character and show model. Does any of the models need a foreign key?
5. Write the two methods `full_name` and `list_roles` that the spec requires. Do you need to write any helper methods?

## spec/character_spec.rb

1. Add the column catchphrase to your character model.
2. Define the method `say_that_thing_you_say` and make the spec pass.

## spec/show_spec.rb
 
1. Associate your show model with the other models.
2. Add all the attributes to the model that the spex requires.