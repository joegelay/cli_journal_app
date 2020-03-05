require_relative 'config/environment'
require 'tty-prompt'

puts "Hello! What is your full name?" 
user_name = gets.chomp

new_journal = Cli.new(user_name)

@name_check = User.find { |user| user.name.downcase == user_name.downcase }
@current_user = User.find_or_create_by(name: user_name)

# where does the logic for the app live?
# can we have instance variables outside a class?
# after we assign the user's name to user_name, where should we send this information to start the logic of our app?
# Does the CLI need to have a user name passed into it on creation?


# binding.pry
new_journal.welcome



