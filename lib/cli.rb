class Interface

    def welcome_message
        puts "Welcome to FoodLocker"
        puts "Please Sign in or Signup"
        puts "Sign in, type: signin"
        puts "Sign up, type: signup"
        log_in_input = get_valid_input(2)
        if log_in_input == 1
            self.signin
        else
            signup
        end
    end

    def get_valid_input(option_num)
        puts "Please enter a number between 1 and #{option_num}"
        user_input = self.input.to_i
        if user_input >= 1 && user_input <= option_num
            user_input
        else
            self.get_valid_input(option_num)
        end
    end

    def get_input
        gets.strip
    end

    def signin
        puts "Please enter your name"
        puts "Press Enter to go back"
        user_name = get_input
        if user_name.empty?
            welcome_message
        end

        user = User.find_by(name: user_name)
        if user
            @logged_in_user = user
            user_page(user)
            
        else
            signin
        end
    end

    def signup
        puts "Please enter your name"
        puts "Press Enter to go back"
        user_name = get_input
        if user_name.empty?
            welcome_message
        end

        user = User.find_by(name: user_input)
        if user
            signin
        else
            User.create(name: user_name)
            signin
        end
    end

    def print_page_options(options)
        options.each_with_index do |option, index|
            puts "#{index+1}. #{option}"
        end
    end

    def user_page(user)
        puts "Hello #{user.name}, welcome back."
        options = ['Create a recipe', 'View my saved recipes', 'find a recipe', 'view my created recipes', 'logout', 'quit']
        print_page_options(options)

        user_input = get_valid_input(options.length)

        case user_input
        when 1
            create_recipe
        when 2
            view_saved_recipes(user) #DONE
        when 3
            find_a_recipe            #DONE
        when 4
            view_created_recipes
        when 5
            welcome_message
        when 6
            abort("Thanks for using FoodLocker")
        end
    end

    def view_saved_recipes(user)
        recipes = user.view_saved_recipes
        recipes.each do |recipe|
            puts "*************"
            puts "name: #{recipe.name}"
            puts "description: #{recipe.description}"
            puts "rating: #{recipe.view_recipe_rating}"
        end
        puts "*************"
        press_enter_to_back
    end

    def press_enter_to_back
        puts "----------------------"
        puts "Press Enter to go back"
        user_input = get_input
        if user_input.empty?
            user_page(user)
        end
        user_input
    end

    def find_a_recipe
        puts "Please enter the name of a recipe"
        user_input = press_enter_to_back
        recipe = Recipe.find_by(name: user_input)
        if recipe
            view_recipe(recipe)
        else
            puts "Sorry, that recipe does not exist"
            find_a_recipe
        end
        
    end

    def clear_console
        50.times {puts ""}
    end

    def view_recipe(recipe)
        clear_console
        puts "NAME: #{recipe.name}"
        puts "RATING: #{recipe.view_recipe_rating}"
        puts "DESCRIPTION:"
        puts "#{recipe.description}"
        puts "---------------------"
        ingredients = recipe.ingredients
        recipe_ingredients = recipe.recipe_ingredients
        ingredients.each_with_index do |ingredient, index|
            puts "#{ingedient.name}: #{recipe_ingredients[index].amount}"
        end
    end


end