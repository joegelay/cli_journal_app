class Cli

    ActiveRecord::Base.logger.level = 1 

    def welcome
        puts "Hello! What is your full name?" 
        user_name = gets.chomp
        
        name_check = User.all.find { |user| user.name.downcase == user_name.downcase }
        
        if name_check
            puts "Welcome back, #{user_name}!"
        else
            new_user = User.create(name: "#{user_name}")
            puts "Whatsup, #{new_user.name}?!"
        end     

    end 


end 