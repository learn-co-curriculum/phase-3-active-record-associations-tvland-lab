class Show < ActiveRecord::Base
    has_many :characters
    has_many :actors, through: :characters
    belongs_to :network

    def actors_list
        actorArray = []
        self.actors.each do |actor|
            actorArray.push(actor.full_name)
        end
        actorArray
    end
end