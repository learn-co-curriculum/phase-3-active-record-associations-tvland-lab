class Show < ActiveRecord::Base
    has_many :characters
    has_many :actors, through: :character
    belongs_to :network

    def actors_list
        actors.all
    end
end