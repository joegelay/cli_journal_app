User.destroy_all
Journal.destroy_all
Entry.destroy_all

joe = User.create(name: "Joe Gelay")
justin = User.create(name: "Justin Sabath")
jesse = User.create(name: "Jesse Pope")
damon = User.create(name: "Damon Chivers")

morning = Journal.create(name: "Morning")
afternoon = Journal.create(name: "Afternoon")
night = Journal.create(name: "Night")

e1 = Entry.create(content: "Morning test one", mood: 3, user: joe, journal: morning)
e2 = Entry.create(content: "Morning test two", mood: 3, user: joe, journal: morning)
e3 = Entry.create(content: "Morning test three", mood: 4, user: justin, journal: morning)
e4 = Entry.create(content: "Morning test four", mood: 5, user: joe, journal: morning)
e5 = Entry.create(content: "Afternoon test one", mood: 3, user: jesse, journal: afternoon)
e6 = Entry.create(content: "Afternoon test two", mood: 1, user: damon, journal: afternoon)
e7 = Entry.create(content: "Afternoon test three", mood: 1, user: damon, journal: afternoon)
e8 = Entry.create(content: "Afternoon test four", mood: 4, user: justin, journal: afternoon)
e9 = Entry.create(content: "Night test one", mood: 5, user: joe, journal: night)
e10 = Entry.create(content: "Night test two", mood: 5, user: justin, journal: night)
e11 = Entry.create(content: "Night test three", mood: 3, user: damon, journal: night)
e12 = Entry.create(content: "Night test four", mood: 2, user: justin, journal: night)