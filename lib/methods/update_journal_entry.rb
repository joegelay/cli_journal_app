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
        if @selected_entry[0].journal.name == "Morning"
            question_to_update = prompt.select("Which question would you like to change your repsonse to?", 
            ["How did you sleep?", "What is one thing that you're grateful for?", 
            "What are you looking forward to today?"])
            if question_to_update == "How did you sleep?"
                sleep_response = prompt.select("How did you sleep?", ["Awful. Nightmarish sleep.", "Meh.", 
                "Pretty good! I feel okay.", "Who needs coffee?! Slept like a rock!"])
                @selected_entry[0].content[0] = "How did you sleep?: " + sleep_response
                @selected_entry[0].save
                binding.pry
            end
        end
        
        question_to_update = prompt.select("Which question would you like to change your repsonse to?", ["quetion", "Mood"])
       
    end 

end 
