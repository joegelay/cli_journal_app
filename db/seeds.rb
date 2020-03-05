Entry.destroy_all
User.destroy_all
Journal.destroy_all

morning = Journal.create(name: "Morning")
afternoon = Journal.create(name: "Afternoon")
night = Journal.create(name: "Night")