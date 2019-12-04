def take_entry
    puts "How do you want to access the database?\n"
    puts "1. See available characters"
    puts "2. See available comics"
    puts "3. other methods\n"
    puts "Enter a number or exit"

    gets.chomp
end

def get_characters
    looper = "y"
    offset_num = 100
    temp = fetch_marvel("characters")

    puts "The available characters are: "
    print_character(temp)

    while looper == "y"
        puts "\n\n"
        puts "next, last, add, back to menu?"
        choice = get_entry

        if choice == "next"
            print_character(fetch_marvel("characters", offset_num))
            offset_num += 100
        elsif choice == "last" && offset_num >= 100
            offset_num -= 200
            print_character(fetch_marvel("characters", offset_num))
        elsif choice == "add"
            add_to_db("characters", offset_num - 100)
        elsif choice == "back to menu"
            looper = "n"
        else
            puts "not a valid entry"
        end
    end
    Screen.clear
end

def get_comics
    looper = "y"
    offset_num = 100
    temp = fetch_marvel("comics")
    puts "The available comics are: "
    print_comic(temp)

    while looper == "y"
        puts "\n\n"
        puts "next, last, back to menu?"
        choice = get_entry

        if choice == "next"
            print_comic(fetch_marvel("comics", offset_num))
            offset_num += 100
        elsif choice == "last" && offset_num >= 100
            offset_num -= 200
            print_comic(fetch_marvel("comics", offset_num))
        elsif choice == "add"
            add_to_db("comics", offset_num - 100)
        elsif choice == "back to menu"
            looper = "n"
        else
            puts "not a valid entry"
        end
    end
    Screen.clear
end

def print_comic(printer)
    printer["data"]["results"].each do |char|
        puts "#{char["id"]}. #{char["title"]}"
    end
end

def print_character(printer)
    printer["data"]["results"].each do |char|
        puts "#{char["id"]}. #{char["name"]}"
    end
end

def get_entry
    gets.chomp
end

def add_to_db(whch, offset_num)
    temp = fetch_marvel(whch, offset_num)

    puts "Which would you like to add? or add all?"
    choice2 = get_entry
    if choice2 == "add all"
        temp["data"]["results"].each do |char|
            if whch == "characters"
                Character.find_or_create_by(char_id: char["id"], name: char["name"], desc: char["description"])
            elsif whch == "comics"
                Comic.find_or_create_by(comic_id: char["id"], name: char["title"], release_date: char["dates"][0]["date"], issue_num: char["issueNumber"], description: char["description"])
            end
        end
    else
        if whch == "characters"
            tmpchar = temp["data"]["results"].select{|item| item["name"] == choice2}
            binding.pry
            Character.find_or_create_by(char_id: tmpchar[0]["id"], name: tmpchar[0]["name"], desc: tmpchar[0]["description"])
        elsif whch == "comics"
            tmpchar = temp["data"]["results"].select{|item| item["title"] == choice2}
            Comic.find_or_create_by(comic_id: tmpchar[0]["id"], name: char["title"], release_date: tmpchar[0]["dates"][0]["date"], issue_num: tmpchar[0]["issueNumber"], description: tmpchar[0]["description"])
        end
    end
                
end

