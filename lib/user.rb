class User < ActiveRecord::Base
    has_many :entries
    has_many :journals, through: :entries 
end 