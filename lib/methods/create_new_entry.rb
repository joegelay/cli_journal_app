

def create_new_entry 
    prompt = TTY::Prompt.new
    selection = prompt.select("Right on! What kind of journal would you like to create?", ["Morning", "Afternoon", 
        "Night"])
    if selection == "Morning"
        morning_entry
    end 
end 

def morning_entry 

    content = []

    prompt = TTY::Prompt.new
    sleep_response = prompt.select("How did you sleep?", ["Awful. Nightmarish sleep.", "Meh.", 
        "Pretty good! I feel okay.", "Who needs coffee?! Slept like a rock!"])
    content << "How did you sleep?: " + sleep_response

    gratitude_response = prompt.ask("What is one thing that you're grateful for?")
    content << "What is one thing that you're grateful for?: " + gratitude_response

    outlook_response = prompt.ask("What are you looking forward to today?")
    content << "What are you looking forward to today?: " + outlook_response

    


    puts content




    # entry = Entry.create(content: content.join(" "), user: name_check, journal: morning)

end 

def afternoon_entry 

end 

def night_entry

end 


