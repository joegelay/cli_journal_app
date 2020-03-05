Entry.destroy_all
User.destroy_all
Journal.destroy_all

morning = Journal.create(name: "Morning")
afternoon = Journal.create(name: "Afternoon")
night = Journal.create(name: "Night")

joe = User.create(name: "Joe Gelay")

Entry.create(content: ["Testing"], mood: 1, user: joe, journal: night)
Entry.create(content: ["Testing"], mood: 5, user: joe, journal: night)
Entry.create(content: ["Testing"], mood: 3, user: joe, journal: night)
