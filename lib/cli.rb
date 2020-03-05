require 'tty-prompt'

class Cli

    ActiveRecord::Base.logger.level = 1 

    def welcome
        if @name_check
            puts "Welcome back, #{@user_name}!"
            main_menu
        else
            puts "Whatsup, #{@user_name}?! Welcome to Journal App!"
            main_menu
        end     
    end 

    def main_menu
        prompt = TTY::Prompt.new

        selection = prompt.select("What would you like to do?", ["Create a new journal entry", "Read a past journal entry", 
            "Update a journal entry", "Delete a journal entry", "Close journal"])
        if selection == "Create a new journal entry"
            create_new_entry
        elsif selection == "Read a past journal entry"
            read_journal_entry
        elsif selection == "Update a journal entry"
            update_journal_entry
        elsif selection == "Delete a journal entry"
            delete_journal_entry 
        end 
        # update to switch case 
    end 
end 