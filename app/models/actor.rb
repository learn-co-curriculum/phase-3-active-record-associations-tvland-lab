class Actor < ActiveRecord::Base
  has_many :characters

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def list_roles
    self.characters.collect do |character| 
      "#{character.name} - #{character.show.name}"
    end.join("\n") 
  end
end