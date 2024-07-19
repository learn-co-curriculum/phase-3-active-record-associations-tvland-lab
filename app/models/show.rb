class Show < ActiveRecord::Base
  belongs_to :network
  has_many :characters
  has_many :actors, through: :characters

  def actors_list
    actors.map do |actor|
      actor.full_name
    end
  end
end
