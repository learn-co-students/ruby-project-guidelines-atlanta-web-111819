def take_entry
    puts "How do you want to access the database?\n"
    puts "1. See available characters"
    puts "2. See available comics"
    puts "3. Access recorded database"
    puts "Enter a number or exit"

    gets.chomp
end
###################################################### API COMMANDS ################################################################
def get_characters
    looper = "y"
    offset_num = 0
    temp = fetch_marvel("characters", offset_num)

    puts "The available characters are: "
    print_character(temp)

    while looper == "y"
        puts "\n\n"
        puts "next, last, jump, add, back to menu?"
        choice = get_entry

        case choice
        when "next"
            offset_num += 100
            print_character(fetch_marvel("characters", offset_num))
        when "last"
            offset_num -= 100
            print_character(fetch_marvel("characters", offset_num))
        when "add"
            add_to_db("characters", offset_num)
        when "jump"
            puts "jump how far (0 or multiple of 100)?"
            ch3 = get_entry
            if ch3.to_i % 100 == 0 or ch3.to_i == 0
                offset_num = ch3.to_i
                print_character(fetch_marvel("characters", offset_num))
            else
                puts "not 0 or multiple of 100"
            end

        when "back to menu"
            looper = "n"
        else
            puts "not a valid entry"
        end
    end
    Screen.clear
end

def get_comics
    looper = "y"
    offset_num = 0
    temp = fetch_marvel("comics", offset_num)
    puts "The available comics are: "
    print_comic(temp)

    while looper == "y"
        puts "\n\n"
        puts "next, last, jump, add, back to menu?"
        choice = get_entry

        case choice
        when "next"
            offset_num += 100
            print_comic(fetch_marvel("comics", offset_num))
        when "last"
            offset_num -= 100
            print_comic(fetch_marvel("comics", offset_num))
        when "add"
            add_to_db("comics", offset_num)
        when "jump"
            puts "jump how far (0 or multiple of 100)?"
            ch3 = get_entry
            if ch3.to_i % 100 == 0 or ch3.to_i == 0
                offset_num = ch3.to_i
                print_comic(fetch_marvel("comics", offset_num))
            else
                puts "not 0 or multiple of 100"
            end

        when "back to menu"
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


def add_to_db(whch, offset_num)
    temp = fetch_marvel(whch, offset_num)

    puts "Which would you like to add? or add all?"
    choice2 = get_entry
    if choice2 == "add all"
        temp["data"]["results"].each do |char|
            if whch == "characters"
                add_character(char)
            elsif whch == "comics"
                add_comic(char)
            end
        end
    else
        if whch == "characters"
            tmpchar = temp["data"]["results"].select{|item| item["name"] == choice2 or item["id"].to_i == choice2.to_i}
            add_character(tmpchar)
        elsif whch == "comics"
            tmpchar = temp["data"]["results"].select{|item| item["title"] == choice2 or item["id"].to_i == choice2.to_i}
            add_comic(tmpchar)
        end
    end
                
end

def add_character(char_info)
    Character.find_or_create_by(char_id: char_info[0]["id"], name: char_info[0]["name"], desc: char_info[0]["description"])
    temp = fetch_comics(char_info[0]["id"])
    tmp_comic = temp["data"]["results"].select{|item| Comic.where(comic_id: item["id"]).exists?}
    tmp_comic.each{|entry| Charactercomic.find_or_create_by(character_id: char_info[0]["id"], comic_id: entry["id"])}
    # binding.pry

end

def add_comic(tmpchar)
    binding.pry
    Comic.find_or_create_by(comic_id: tmpchar["id"], name: tmpchar["title"], release_date: tmpchar["dates"][0]["date"], issue_num: tmpchar["issueNumber"], description: tmpchar["description"])
    temp = fetch_characters(tmpchar["id"])
    tmp_comic = temp["data"]["results"].select{|item| Character.where(char_id: item["id"]).exists?}
    tmp_comic.each{|entry| Charactercomic.find_or_create_by(comic_id: tmpchar["id"], character_id: entry["id"])}
end

################################################# DATABASE METHODS ##############################################################################

def open_database
    Screen.clear
    puts "You are now in the database."
    puts "1. Access Character database"
    puts "2. Access Comic database"
    puts "3. Access relations database"

    choice = get_entry

    case choice
    when "1"
        char_database
    when "2"
        comic_database
    when "3"
    else
        puts "Not a valid entry"
    end

end

def char_database
    Screen.clear
    puts "\n Character database"
    puts "1. Display database"
    puts "2. Clear database"

    choice = get_entry

    case choice
    when "1"
        display_char
    when "2"
        Character.delete_all
    end
end

def display_char
    Character.all.each do |char|
        # binding.pry
        puts "#{char.id} | #{char.char_id} | #{char.name}"
    end
    puts "'select' Character or 'exit'"
    choice = get_entry

    case choice
    when "select"
        puts "Enter id of entry you wish to select"
        choice = get_entry
        temp = Character.find(choice.to_i)
        puts "*" * 30
        puts "Name: #{temp.name}"
        puts "Marvel ID: #{temp.char_id}"
        puts "Description: #{temp.desc}"
        puts "\n Del? y or n"
        choice2 = get_entry

        if choice2 == "y"
            Character.delete(choice.to_i)
        end

    when "exit"
        Screen.clear
        display_char
    end

end

def comic_database
    Screen.clear
    puts "\n Comic database"
    puts "1. Display database"
    puts "2. Clear database"

    choice = get_entry

    case choice
    when "1"
        display_comic
    when "2"
        Comic.delete_all
    end
end

def display_comic
    Comic.all.each do |char|
        # binding.pry
        puts "#{char.id} | #{char.comic_id} | #{char.name}"
    end
    puts "'select' Character or 'exit'"
    choice = get_entry

    case choice
    when "select"
        puts "Enter id of entry you wish to select"
        choice = get_entry
        temp = Comic.find(choice.to_i)
        puts "*" * 30
        puts "Name: #{temp.name}"
        puts "Marvel ID: #{temp.comic_id}"
        puts "Issue #: #{temp.issue_num}"
        puts "Release Date: #{temp.release_date}"
        puts "Description: #{temp.description}"
        puts "\n Del? y or n"
        choice2 = get_entry

        if choice2 == "y"
            Comic.delete(choice.to_i)
            display_comic
        end

    when "exit"
        Screen.clear
        display_comic
    end

end

################################################# GENERAL METHODS #########################################################################

def get_entry
    gets.chomp
end

