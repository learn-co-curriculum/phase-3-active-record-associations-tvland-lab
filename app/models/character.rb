class Character < ActiveRecord::Base
    belongs_to :actor
    belongs_to :show

    def actor
        self.actor
    end

    def show
        self.show
    end

    def say_that_thing_you_say
        self.catchphrase
    end
  
end