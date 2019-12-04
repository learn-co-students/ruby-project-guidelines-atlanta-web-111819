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
        puts "next, last, back to menu?"
        choice = get_entry

        if choice == "next"
            print_character(fetch_marvel("characters", offset_num))
            offset_num += 100
        elsif choice == "last" && offset_num >= 100
            offset_num -= 200
            print_character(fetch_marvel("characters", offset_num))
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
