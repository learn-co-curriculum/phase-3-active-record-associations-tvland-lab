class Show < ActiveRecord::Base
  belongs_to :network
  has_many :characters

  def actors_list
    self.characters.map do |c|
      actor=c.actor
      "#{actor.first_name} #{actor.last_name}"
    end
  end

end
