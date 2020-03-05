class User < ActiveRecord::Base
    has_many :entries
    has_many :journals, through: :entries 

    def main_menu
        prompt = TTY::Prompt.new

        selection = prompt.select("What would you like to do?", ["Create a new journal entry", "Read a past journal entry", 
            "Update a journal entry", "Delete a journal entry", "Close journal"])

        case selection 
        when "Create a new journal entry"
            create_new_entry
        when "Read a past journal entry"
            read_journal_entry
        when "Update a journal entry"
            update_journal_shows_entry
        when "Delete a journal entry"
            delete_journal_entry 
        end 
    end 

    def create_new_entry 
        prompt = TTY::Prompt.new
        selection = prompt.select("Right on! What kind of journal would you like to create?", ["Morning", "Afternoon", 
            "Night"])
        if selection == "Morning"
            morning_entry
        elsif selection == "Afternoon"
            afternoon_entry
        else 
            night_entry 
        end 
        main_menu
    end 

    def new_journal_entry(content, mood_response, journal_name)
        self.entries.create(content: content, mood: mood_response, journal: journal_name)
    end

    def morning_entry 
        morning = Journal.all.find { |journal| journal.name == "Morning" }
    
        content = []
    
        prompt = TTY::Prompt.new
        sleep_response = prompt.select("How did you sleep?", ["Awful. Nightmarish sleep.", "Meh.", 
            "Pretty good! I feel okay.", "Who needs coffee?! Slept like a rock!"])
        content << "How did you sleep?: " + sleep_response
    
        gratitude_response = prompt.ask("What is one thing that you're grateful for?")
        content << "What is one thing that you're grateful for?: " + gratitude_response
    
        outlook_response = prompt.ask("What are you looking forward to today?")
        content << "What are you looking forward to today?: " + outlook_response
    
        mood_response = prompt.select("How are you feeling (1-5)?", [1,2,3,4,5])
        
        new_journal_entry(content, mood_response, morning)
        
        puts "Thank you for sharing! Have a great day!"
    end 
    
    def afternoon_entry 
        afternoon = Journal.all.find { |journal| journal.name == "Afternoon" }
    
        content = []
    
        prompt = TTY::Prompt.new
        morning_response = prompt.select("How was your morning?", ["Shoot me.", "I want to go back to bed.", "Not bad.", 
            "Great morning. Feeling awesome.", "BEST MORNING EVER! STOKED FOR THE REST OF THE DAY! LIFE IS BEAUTIFUL!"])
        content << "How was your morning?: " + morning_response
    
        lunch_response = prompt.select("Have you eaten lunch?", ["Yes", "Not yet."])
        content << "Have you eaten lunch?: " + lunch_response
    
        if lunch_response == "Yes"
            lunch_response_two = prompt.ask("What did you eat?")
            content << "What did you eat?: " + lunch_response_two
        else 
            puts "Go eat!"
        end 
    
        mood_response = prompt.select("How are you feeling (1-5)?", [1,2,3,4,5])
        
        new_journal_entry(content, mood_response, afternoon)
    
        puts "\nKeep on keeping on!\n\n"
    end 
    
    def night_entry
        night = Journal.all.find { |journal| journal.name == "Night" }
    
        content = []
    
        prompt = TTY::Prompt.new
        night_response = prompt.ask("What were three amazing things that happened today?")
        content << "What were three amazing things that happened today?: " + night_response
    
        dinner_response = prompt.select("Have you eaten dinner?", ["Yes", "Not yet."])
        content << "Have you eaten dinner?: " + dinner_response
    
        if dinner_response == "Yes"
            dinner_response_two = prompt.ask("What did you eat?")
            content << "What did you eat?: " + dinner_response_two
        else 
            puts "Go eat!"
        end 
    
        mood_response = prompt.select("How are you feeling (1-5)?", [1,2,3,4,5])
        
        new_journal_entry(content, mood_response, night)
    
        puts "\nPut the screen away and relax for a while. Sleep well!\n\n"
        puts "
        ┌▀█┌▀█┌▀█┌▀█┌▀█┌▀█┌▀█
        ┌▀█╔══╗╔══╗╔══╗╔══╗▀█
        ┌▀█║╔═╣║╔╗║║╔╗║╚╗╗║▀█
        ┌▀█║╚╗║║╚╝║║╚╝║╔╩╝║▀█
        ┌▀█╚══╝╚══╝╚══╝╚══╝▀█
        ┌▀█┌▀█┌▀█┌▀█┌▀█┌▀█┌▀█
        ┌▀█░░░░░░░░░░░░░░░░▀█
        ┌▀█░░█▌▌█▐▀▐░▌▀█▀░░▀█
        ┌▀█░░█▐▌█▐▐▐▀▌░█░░░▀█
        ┌▀█░░█░▌█▐█▐░▌░█░░░▀█
        ┌▀█░░░░░░░░░░░░░░░░▀█
        ┌▀█┌▀█┌▀█┌▀█┌▀█┌▀█┌▀█ "
        puts "\n\n"
    end 

    #READ FUNCTIONALITY STARTS BELOW
    def read_journal_entry 
        ask_for_date
        puts "\n~~~~~~~~~~~~~~~~~~\nContent:\n\n#{@selected_entry[0].content.join("\n\n")}\n\nMood: #{@selected_entry[0].mood}\n~~~~~~~~~~~~~~~~~~\n\n"
        main_menu
    end 
    
    def ask_for_date
        prompt = TTY::Prompt.new
        @date = prompt.ask("What date do you want to search? (MM/DD/YYYY)") do |q|
                q.validate(/^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$/, "Invalid date format, let's try that again...")
        end 
        date_entries = Entry.select { |entry| entry.created_at.strftime("%m/%d/%Y") == @date }
        @user_date_entries = date_entries.select { |entry| entry.user == self }
        select_entry
    end 

    def select_entry
        prompt = TTY::Prompt.new
        if @user_date_entries.length < 1
            puts "Looks like you don't have any entries from that day! Choose another day..."
            ask_for_date
        else 
            ask_for_journal
        end 
    end 

    def ask_for_journal
        prompt = TTY::Prompt.new
        journal_type = prompt.select("Which journal from #{@date} would you like to select?", ["Morning", "Afternoon", "Night"])
        @selected_entry = @user_date_entries.select { |entry| entry.journal.name == journal_type }
        if @selected_entry.length < 1 
            puts "Whoops! You don't have a journal of that type on this day. Choose a different journal."
            ask_for_journal
        end
    end 

    # UPDATE BELOW
    def update_journal_shows_entry
        prompt = TTY::Prompt.new
        ask_for_date
        puts "\n~~~~~~~~~~~~~~~~~~\nContent:\n\n#{@selected_entry[0].content.join("\n\n")}\n\nMood: #{@selected_entry[0].mood}\n~~~~~~~~~~~~~~~~~~\n\n"
        update_journal_content_or_mood
    end 
        
    def update_journal_content_or_mood
        prompt = TTY::Prompt.new
        @section_to_update = prompt.select("Which section would you like to update", ["Content", "Mood"])
        update_journal_mood
    end 

    def update_journal_mood
        prompt = TTY::Prompt.new
        if @section_to_update == "Mood"
            puts "Please update your mood score below..."
            mood_response = prompt.select("How are you feeling (1-5)?", [1,2,3,4,5])
            @selected_entry[0].mood = mood_response 
            @selected_entry[0].save
            puts "Mood updated! Hope you changed it for the better 😎"
            main_menu
        else
            update_journal_content
        end
    end 

    def update_journal_content
        prompt = TTY::Prompt.new

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
        puts "Journal updated and saved!"
        main_menu
    end 
    
    def delete_journal_entry 
        ask_for_date
        @selected_entry[0].destroy 
        puts "Consider it torn up and burned! 🔥"
        main_menu
    end 
end 

   
