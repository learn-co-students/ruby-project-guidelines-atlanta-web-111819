puts "Creating test characters"
Character.create(char_id: 25, name: "Spider-Man", desc: "Friendly Neighborhood Hero")
Character.create(char_id: 38, name: "Iron-man", desc: "Billionare, Playboy, Philanthropist")
Character.create(char_id: 12, name: "Hulk", desc: "Gamma Radiation")
Character.create(char_id: 30, name: "Captain American", desc: "The First Avenger")
puts "Done"

puts "Creating test comics"
Comic.create(comic_id: 34, name: "Amazing Friends Vol. 1", release_date: "2020-11-19", issue_num: 1, description: "The First One")
Comic.create(comic_id: 35, name: "Amazing Enemies Vol. 1", release_date: "2018-12-29", issue_num: 1, description: "The Bad One")
Comic.create(comic_id: 36, name: "Amazing Friends Vol. 2", release_date: "2020-12-13", issue_num: 2, description: "Actually the third one, but we had publication issues")
Comic.create(comic_id: 37, name: "Amazing Enemies Vol. 2", release_date: "2019-01-05", issue_num: 2, description: "The Final One")
puts "Done"

puts "Creating test relations"
4.times do
    Charactercomic.create(character_id: Character.all.sample.char_id, comic_id: Comic.all.sample.comic_id)
end
puts "Done"



# puts "Creating Comics"

# temp = fetch_marvel_comics
# temp["data"]["results"].each do |entry|
#     Comic.create(comic_id: entry["id"], name: entry["title"], release_date: entry["dates"][0]["date"], issue_num: entry["issueNumber"], description: entry["description"])
# end

Character.delete_all
Comic.delete_all
Charactercomic.delete_all
