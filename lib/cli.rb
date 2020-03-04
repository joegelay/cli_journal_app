require 'tty-prompt'

class Cli

    ActiveRecord::Base.logger.level = 1 

    def welcome
        puts "Hello! What is your full name?" 
        user_name = gets.chomp
        
        @name_check = User.all.find { |user| user.name.downcase == user_name.downcase }

        prompt = TTY::Prompt.new
        
        if @name_check
            puts "Welcome back, #{user_name}!"
            selection = prompt.select("What would you like to do?", ["Create a new journal entry", "Read a past journal entry", 
                "Update a journal entry", "Delete a journal entry"])
            if selection == "Create a new journal entry"
                create_new_entry
            end 
            
        else
            new_user = User.create(name: "#{user_name}")
            puts "Whatsup, #{new_user.name}?!"
        end     

        binding.pry
    end 
end 