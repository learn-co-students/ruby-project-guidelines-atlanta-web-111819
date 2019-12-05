require_relative '../config/environment'

puts "WELCOME TO THE MARVEL DATABASE"
puts "\n\n\n"

lpr = "y"

while lpr == "y"
    puts "\n"
    choice = take_entry

    case choice
    when "1"
        get_characters
    when "2"
        get_comics
    when "3"
        open_database
    when "exit"
        lpr = "n"
    end

    # if choice == "1"
    # get_characters
    # elsif choice == "2"
    # get_comics
    # elsif choice == "exit"
    #     lpr = "n"
    # end
end









