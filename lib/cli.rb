require 'tty-prompt'

class Cli

    attr_reader :current_user

    ActiveRecord::Base.logger.level = 1 

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
    

# UPDATE FUNCTIONALITY STARTS BELOW

def update_journal_entry 
    prompt = TTY::Prompt.new
    ask_for_date
    puts "Content: #{@selected_entry[0].content.join("\n")} \nMood: #{@selected_entry[0].mood}"  
    
    section_to_update = prompt.select("Which section would you like to update", ["Content", "Mood"])
    if section_to_update == "Mood"
        puts "Please update your mood score below..."
        mood_response = prompt.select("How are you feeling (1-5)?", [1,2,3,4,5])
        @selected_entry[0].mood = mood_response 
        @selected_entry[0].save
        puts "Mood updated! Hope you changed it for the better 😎"
    else
        if @selected_entry[0].journal.name == "Morning"
            question_to_update = prompt.select("Which question would you like to change your repsonse to?", 
            ["How did you sleep?", "What is one thing that you're grateful for?", 
            "What are you looking forward to today?"])
            if question_to_update == "How did you sleep?"
                sleep_response = prompt.select("How did you sleep?", ["Awful. Nightmarish sleep.", "Meh.", 
                "Pretty good! I feel okay.", "Who needs coffee?! Slept like a rock!"])
                @selected_entry[0].content[0] = "How did you sleep?: " + sleep_response
                @selected_entry[0].save
                
            elsif question_to_update == "What is one thing that you're grateful for?"
                gratitude_response = prompt.ask("What is one thing that you're grateful for?")
                @selected_entry[0].content[1] = "What is one thing that you're grateful for?: " + gratitude_response
                @selected_entry[0].save
            else 
                outlook_response = prompt.ask("What are you looking forward to today?")
                @selected_entry[0].content[2] =  "What are you looking forward to today?: " + outlook_response
                @selected_entry[0].save
            end
        elsif @selected_entry[0].journal.name == "Afternoon"
            question_to_update = prompt.select("Which question would you like to change your repsonse to?", 
            ["How was your morning?", "Have you eaten lunch?"])
            if question_to_update == "How was your morning?"
                morning_response = prompt.select("How was your morning?", ["Shoot me.", "I want to go back to bed.", "Not bad.", 
                "Great morning. Feeling awesome.", "BEST MORNING EVER! STOKED FOR THE REST OF THE DAY! LIFE IS BEAUTIFUL!"])
                @selected_entry[0].content[0] = "How was your morning?: " + morning_response
                @selected_entry[0].save
            else 
                lunch_response = prompt.select("Have you eaten lunch?", ["Yes", "Not yet."])
                @selected_entry[0].content[1] = "Have you eaten lunch?: " + lunch_response

                if lunch_response == "Yes"
                    lunch_response_two = prompt.ask("What did you eat?")
                    @selected_entry[0].content[2] = "What did you eat?: " + lunch_response_two
                else 
                    @selected_entry[0].content[2] = ""
                    puts "Go eat!"
                end 
                @selected_entry[0].save
            end 
        else 
            question_to_update = prompt.select("Which question would you like to change your repsonse to?", 
            ["What were three amazing things that happened today?", "Have you eaten dinner?"])
            if question_to_update == "What were three amazing things that happened today?"
                night_response = prompt.ask("What were three amazing things that happened today?")
                @selected_entry[0].content[0] = "What were three amazing things that happened today?: " + night_response
                @selected_entry[0].save
            else 
                dinner_response = prompt.select("Have you eaten dinner?", ["Yes", "Not yet."])
                @selected_entry[0].content[1] = "Have you eaten dinner?: " + dinner_response

                if dinner_response == "Yes"
                dinner_response_two = prompt.ask("What did you eat?")
                @selected_entry[0].content[2] = "What did you eat?: " + dinner_response_two
                else 
                    @selected_entry[0].content[2] = ""
                    puts "Go eat!"
                end 
                @selected_entry[0].save
            end 
        end   
    end 
    puts "Journal updated and saved!"
    main_menu
end 

# DELETE FUNCTIONALITY STARTS BELOW

def delete_journal_entry 
    ask_for_date
    @selected_entry[0].destroy 
    puts "Consider it torn up and burned! 🔥"
    main_menu
end 
end 