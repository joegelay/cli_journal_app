def read_journal_entry 
    prompt = TTY::Prompt.new
    date = prompt.ask("What date do you want to search? (MM/DD/YYYY)") do |q|
            q.validate(/^([0-2][0-9]|(3)[0-1])(\/)(((0)[0-9])|((1)[0-2]))(\/)\d{4}$/, "Invalid date format, let's try that again...")
    end 
    puts date 
end 


