def take_entry
    puts "How do you want to access the database?\n"
    puts "1. Get list of characters."
    puts "2. Get list of comics"
    puts "3. other methods\n"
    puts "Enter a number"

    gets.chomp
end

def get_characters
    return Character.all
end

def get_comics
    return Comic.all
end

def get_methods

end