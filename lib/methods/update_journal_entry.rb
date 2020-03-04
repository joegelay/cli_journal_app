def update_journal_entry 
    prompt = TTY::Prompt.new
    read_journal_entry 

    section_to_update = prompt.select("Which section would you like to update", ["Content", "Mood"])
    if section_to_update == "Mood"
        puts "Please update your mood score below..."
        mood_response = prompt.select("How are you feeling (1-5)?", [1,2,3,4,5])
        @selected_entry[0].mood = mood_response 
        @selected_entry[0].save
        puts "Mood updated! Hope you changed it for the better 😎"
    else 
        puts ""
    end 

end 
