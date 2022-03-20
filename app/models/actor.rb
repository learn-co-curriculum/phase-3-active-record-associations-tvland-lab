require "pry"
class Actor < ActiveRecord::Base
    has_many :characters
    has_many :shows , through: :characters

    def full_name
        "#{first_name} #{last_name}"
    end

    # def list_roles
    #     # binding.pry
    #     "#{characters.name} - #{shows.name}"
    # end

    def list_roles
        self.characters.map do |character|
          "#{character.name} - #{character.show.name}"
        end
      end
end

# peter = Actor.create(first_name: "Peter", last_name: "Dinklage")
# thrones = Show.create(name: "Game of Thrones")
# tyrion = Character.create(name: "Tyrion Lannister", actor_id: peter.id, show_id: thrones.id)
# # ['Tyrion Lannister - Game of Thrones']
