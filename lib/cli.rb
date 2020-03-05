require 'tty-prompt'

class Cli
    attr_reader :current_user

    def welcome
        puts "Hello! What is your full name?" 
        user_name = gets.chomp
        
        name_check = User.find { |user| user.name.downcase == user_name.downcase }
        @current_user = User.find_or_create_by(name: user_name)

        if name_check
            puts "Welcome back, #{user_name}!"
            current_user.main_menu
        else
            puts "Whatsup, #{user_name}?! Welcome to Journal App!"
            current_user.main_menu
        end     
    end 
end 