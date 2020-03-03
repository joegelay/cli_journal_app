class Cli

    ActiveRecord::Base.logger.level = 1 

    def welcome
        puts "Hello! What is your name?" 
        user_name = gets.chomp 

        new_user = User.create(name: "#{user_name}")

        puts "Whatsup, #{new_user.name}?!"

    end 


end 