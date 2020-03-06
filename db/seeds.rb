Entry.destroy_all
User.destroy_all
Journal.destroy_all

ActiveRecord::Base.record_timestamps = true
    
morning = Journal.create(name: "Morning")
afternoon = Journal.create(name: "Afternoon")
night = Journal.create(name: "Night")

joe = User.create(name: "Joe Gelay")

Entry.create(content: ["What a great morning!"], mood: 3, user: joe, journal: afternoon)
Entry.create(content: ["Awful day. Stepped in poop."], mood: 1, user: joe, journal: night)
Entry.create(content: ["Best day ever!!!"], mood: 5, user: joe, journal: morning, created_at: "2020-03-01 01:22:41 UTC")
Entry.create(content: ["Today has been pretty good."], mood: 3, user: joe, journal: morning, created_at: "2020-03-02 01:22:41 UTC")
Entry.create(content: ["Not a bad morning."], mood: 3, user: joe, journal: morning, created_at: "2020-03-03 01:22:41 UTC")
Entry.create(content: ["Best day in a long time!"], mood: 5, user: joe, journal: night, created_at: "2020-02-04 01:22:41 UTC")
Entry.create(content: ["I love my life!!!!"], mood: 5, user: joe, journal: night, created_at: "2020-03-05 01:22:41 UTC")
Entry.create(content: ["Today was great :)"], mood: 5, user: joe, journal: night, created_at: "2020-01-08 01:22:41 UTC")
Entry.create(content: ["Ugh. Shitty morning."], mood: 2, user: joe, journal: morning, created_at: "2020-01-08 01:22:41 UTC")
Entry.create(content: ["Great afternoon!"], mood: 4, user: joe, journal: afternoon, created_at: "2020-01-08 01:22:41 UTC")






