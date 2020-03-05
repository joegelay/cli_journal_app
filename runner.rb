require_relative 'config/environment'
require 'tty-prompt'

# binding.pry

puts "Hello! What is your full name?" 
@user_name = gets.chomp

@name_check = User.find { |user| user.name.downcase == @user_name.downcase }
@current_user = User.find_or_create_by(name: @user_name)

new_journal = Cli.new
new_journal.welcome


