class User < ActiveRecord::Base
    has_many :entries
    has_many :journals, through: :entries 

    def first_name
        self.name.split.first 
    end 

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
            update_journal_entry
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
        # helper method to pass in relevant journal
    
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
    
        puts "Keep on keeping on!"
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
    
        puts "Put the screen away and relax for a while. Sleep well!"
    end 

    #READ FUNCTIONALITY STARTS BELOW

    def read_journal_entry 
        ask_for_date
        puts "Content: #{@selected_entry[0].content.join("\n")} \nMood: #{@selected_entry[0].mood}"  
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
    


end 

   
