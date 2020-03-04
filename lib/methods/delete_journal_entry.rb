def delete_journal_entry 
    ask_for_date
    @selected_entry[0].destroy 
    puts "Consider it torn up and burned! 🔥"
    main_menu
end 