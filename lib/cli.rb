require 'tty-prompt'

class Cli

    ActiveRecord::Base.logger.level = 1 

    def welcome
        puts "Hello! What is your full name?" 
        user_name = gets.chomp
        
        name_check = User.find { |user| user.name.downcase == user_name.downcase }
        @current_user = User.find_or_create_by(name: user_name)

        if name_check
            puts "Welcome back, #{user_name}!"
            main_menu
        else
            puts "Whatsup, #{user_name}?! Welcome to Journal App!"
            main_menu
        end     
    end 

    def main_menu
        prompt = TTY::Prompt.new

        selection = prompt.select("What would you like to do?", ["Create a new journal entry", "Read a past journal entry", 
            "Update a journal entry", "Delete a journal entry"])
        if selection == "Create a new journal entry"
            create_new_entry
        end 
    end 
end 