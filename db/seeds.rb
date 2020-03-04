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