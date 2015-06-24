# Guide to Solving and Reviewing ActiveRecord TV Land

## spec/actor.rb

The first spec in this lab is testing if your Actor model has the attributes first and last name, but the error message you are getting is `Could not find table actors` as seen below:

```bash
Actor
  has a first and last name (FAILED - 1)

Failures:
1) Actor has a first and last name
   Failure/Error: actor = Actor.create(:first_name => "Emilia", :last_name => "Clarke") ActiveRecord::StatementInvalid:
      Could not find table 'actors'
```

To pass this test you will have to write a new migration `004_create_actors.rb` for the Actor model to create the actor table in the database with the attributes `first_name` and `last_name`. Since migration files always run in order by file name, this migration will always run after the previous three. Also remember, it's important for the class name for the migration to match the last part of the file name (`class CreateActors` and `create_actors`).

```ruby
class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :first_name
      t.string :last_name
    end
  end
end
```
After running `rake:db migrate` and `rspec` you should get this error:

```bash
Actor
  has a first and last name
  has associated characters in an array (FAILED - 1)

Failures:

  1) Actor has associated characters in an array
     Failure/Error: khaleesi = Character.new(:name => "Khaleesi")
     ActiveRecord::StatementInvalid:
       Could not find table 'characters'
```

Create a new migration `005_create_characters.rb` for Characters with the attributes `name` and `show_id`.

```ruby
class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.integer :show_id
    end
  end
end
```
Run `rake db:migrate` and `rspec` again. Now you will notice the test is still not passing, but you have a new error message.

```bash
Actor
  has a first and last name
  has associated characters in an array (FAILED - 1)

Failures:

  1) Actor has associated characters in an array
     Failure/Error: khaleesi.actor = emilia
     NoMethodError:
       undefined method `actor=' for #<Character id: nil, name: "Khaleesi", show_id: nil
```
### Discussing the associations in this domain model
Let's talk about associating our models. How do our models relate to each other in real life? How many characters is an actor playing? Is a character only played by one actor? For the purpose of this lab we are going to asume that a character is played by one actor and an actor can play many characters. We also are going to asume that a show belongs to a network.

So, a character `belongs_to` an actor and an actor `has_many` characters. 
Aside belonging to an actor, the character also `belongs_to` a show. A show `has_many` characters, and it `belongs_to` a network. A network `has_many` shows.

But how are actors and shows related? Since characters are directly related to shows and actors, an actor can "know" about its shows through its characters. Likewise, a show knows about its actors through its characters. So we can say that an actor `has_many :shows, through: :characters` and also that a show `has_many :actors, through: :characters`.


### Creating the associations
We created the Actor and Character tabels in the database but we did not add the association between them to the code in our models. So for this test to pass you will have to add `belongs_to :actor` into your Character model and `has_many :characters` to your Actor model. This is a macro that creates, among other methods, an `actor=` method in the `Character` model. For more about this, you can refer to the [ActiveRecord documentation](http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html).

Your new error message now is:

```bash
Actor
  has a first and last name
  has associated characters in an array (FAILED - 1)

Failures:

  1) Actor has associated characters in an array
     Failure/Error: khaleesi.actor = emilia
     ActiveModel::MissingAttributeError:
       can't write unknown attribute `actor_id`
```
### Adding a foreign key
Because a character `belongs_to` an actor, which means there can only be one actor playing this character, we need to insert the foreign key `actor_id` in the characters table. If we had the foreign key in the actors table, we would keep adding data to our table horizontally and this would break the relational database rules.

Now we need to tell the tables how to connect to each other by adding the `actor_id` to the characters table, creating a new migration `006_add_actor_id_to_characters.rb` for this.

```ruby
class AddActorIdToCharacters < ActiveRecord::Migration
  def change
    add_column :characters, :actor_id, :integer
  end
end
```
You should have 3 test passing now for the Actor spec.

```bash
Actor
  has a first and last name
  has associated characters in an array
  can build its associated characters
  can build its associated shows through its characters (FAILED - 1)

Failures:

  1) Actor can build its associated shows through its characters
     Failure/Error: khaleesi.show = got
     NoMethodError:
       undefined method `show=' for #<Character:0x007fea73a264e8>
```
To pass this test your Actor, Charcter and Show models should look like this:

```ruby
class Actor < ActiveRecord::Base
  has_many :characters
  has_many :shows, through: :characters
end
```

```ruby
class Character < ActiveRecord::Base
  belongs_to :actor
  belongs_to :show
end
```

```ruby
class Show < ActiveRecord::Base
  has_many :characters
  has_many :actors, through: :characters
end
```
Run `rspec`, your new error should be: 

```bash
Actor
  has a first and last name
  has associated characters in an array
  can build its associated characters
  can build its associated shows through its characters
  can list its full name (FAILED - 1)

Failures:

  1) Actor can list its full name
     Failure/Error: expect(emilia.full_name).to eq("Emilia Clarke")
     NoMethodError:
       undefined method `full_name' for #<Actor id: nil, first_name: "Emilia", last_name: "Clarke">
```

It's time to write a method called `full_name` in your Actor model.

```ruby
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
```

Your last error in the Actor spec is:

```bash
Actor
  has a first and last name
  has associated characters in an array
  can build its associated characters
  can build its associated shows through its characters
  can list its full name
  can list all of its shows and characters (FAILED - 1)

Failures:

  1) Actor can list all of its shows and characters
     Failure/Error: expect(emilia.list_roles).to eq("Khaleesi - Game of Thrones")
     NoMethodError:
       undefined method `list_roles' for #<Actor id: nil, first_name: "Emilia", last_name: "Clarke">
       
```
Lets write the list_roles method in our actor model.

```ruby
def list_roles
end
```

```bash
Actor
  has a first and last name
  has associated characters in an array
  can build its associated characters
  can build its associated shows through its characters
  can list its full name
  can list all of its shows and characters (FAILED - 1)

Failures:

  1) Actor can list all of its shows and characters
     Failure/Error: expect(emilia.list_roles).to eq("Khaleesi - Game of Thrones")
       
       expected: "Khaleesi - Game of Thrones"
            got: nil
       
       (compared using ==)
```
Lets try to extract the character name and the show name.


```ruby
def list_roles
    characters.collect do |character|
      "#{character.name} - #{character.show.name}"
    end.join('')
  end
```


## spec/character.rb

After passing all the test for the Actor model, the first two of your test for the Character model should also pass.

```bash
Character
  belongs to an actor
  belongs to a show
  has a catchphrase (FAILED - 1)

Failures:

  1) Character has a catchphrase
     Failure/Error: urkel.catchphrase = "Did I do that?"
     NoMethodError:
       undefined method `catchphrase=' for #<Character:0x007feb2d04d498>
```
To pass your third test in this spec you will create a new migration `007_add_catchphrase_to_character.rb` to add the attribute `catchphrase` to your character model

```ruby
class AddCatchphraseToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :catchphrase, :string
  end
end
```

and after running `rake db:migrate`, the next failure we see when we run rspec is `undefined method say_that_thing_you_say` add the method `say_that_thing_you_say` to your Character model.

```ruby
def say_that_thing_you_say
  "#{self.name} always says: #{self.catchphrase}"
end
```
Run rspec again

```bash
Character
  belongs to an actor
  belongs to a show
  has a catchphrase
  can build its associated show
  can chain-build associations to which it belongs (FAILED - 1)

Failures:

  1) Character can chain-build associations to which it belongs
     Failure/Error: malcolm.build_show(:name => "Firefly").build_network(:call_letters => "Fox")
     NoMethodError:
       undefined method `build_network' for #<Show id: nil, name: "Firefly", network_id: nil>
```
You'll only need to add the `belongs_to :network` association to your Show model for this test. `build_other` is a class method that comes with the `belongs_to` association.

Now all your spec tests for Actor, Character and Network are passing.

## spec/show.rb
```ruby
Show
  has data attributes (FAILED - 1)

Failures:

  1) Show has data attributes
     Failure/Error: community = Show.create(:name => "Community", :day => "Thursday", :season => "Winter")
     NameError:
       undefined local variable or method `day=' for #<Show id: nil, name: "Community", network_id: nil>
```
Add the file `008_add_day_and_season_to_show.rb` to your migrations, with the `day` and `season` attributes.

```ruby
class AddDayAndSeasonToShow < ActiveRecord::Migration
  def change
    add_column :shows, :day, :string
    add_column :shows, :season, :string
  end
end
```

Your last test in this lab 

```bash
Show
  has data attributes
  has many characters in an array
  can build its characters through a method
  should have a genre (FAILED - 1)

Failures:

  1) Show should have a genre
     Failure/Error: show.genre = "Dramedy"
     NoMethodError:
       undefined method `genre=' for #<Show:0x007fd3c3b54e08>
```

Create a new migration `009_add_genre_to_show.rb` and add the `genre` attribute to your Show table.

```ruby
class AddGenreToShow < ActiveRecord::Migration
  def change
    add_column :shows, :genre, :string
  end
end
```

Now all the tests should be passing!
