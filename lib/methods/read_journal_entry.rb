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
    @user_date_entries = date_entries.select { |entry| entry.user == @current_user }
    select_entry
end 

def select_entry
    prompt = TTY::Prompt.new
    if @user_date_entries.length < 1
        puts "Looks like you don't have any entries from that day! Choose another day..."
        ask_for_date
    else 
        journal_type = prompt.select("Which journal from #{@date} would you like to see?", ["Morning", "Afternoon", "Night"])
        @selected_entry = @user_date_entries.select { |entry| entry.journal.name == journal_type }
        #add in fucntionality for if journal doesn't exist 
    end 
end 




