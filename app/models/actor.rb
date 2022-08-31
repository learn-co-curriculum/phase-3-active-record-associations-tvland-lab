class Actor < ActiveRecord::Base
    has_many :characters
    has_many :shows, through: :characters

    def full_name
        self.first_name + " " + self.last_name
    end

    def list_roles
        charArray = []
        self.characters.each do |character|
            charArray.push(character.name + " - " + character.show.name)
        end
        charArray
    end
end