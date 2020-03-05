class User < ActiveRecord::Base
    has_many :entries
    has_many :journals, through: :entries 

    def first_name
        self.name.split.first 
    end 
end 