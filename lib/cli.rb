class Interface

    def welcome_message
        clear_console
        puts "Welcome to FoodLocker"
        puts "Please Sign in or Signup"
        # puts "Sign in, type: signin"
        # puts "Sign up, type: signup"
        options = ['Sign in', 'Sign up']
        print_page_options(options)

        log_in_input = get_valid_input(options.length)
        if log_in_input == 1
            self.signin
        else
            signup
        end
    end

    def get_valid_input(option_num)
        puts "Please enter a number between 1 and #{option_num}"

        user_input = self.get_input.to_i
        if user_input >= 1 && user_input <= option_num
            user_input
        else
            self.get_valid_input(option_num)
        end
    end

    def get_input
        gets.strip
    end

    def signin(new_user = false)
        clear_console
        puts "Please enter your name" if !new_user
        puts "Please type your name again to login." if new_user
        puts "Press Enter to go back"

        user_name = get_input
        if user_name.empty?
            welcome_message
        end

        user = User.find_by(name: user_name)
        if user
            @logged_in_user = user
            user_page
            
        else
            signin
        end
    end

    def signup
        clear_console
        puts "Please enter your name"
        puts "Press Enter to go back"

        user_name = get_input
        if user_name.empty?
            welcome_message
        end

        user = User.find_by(name: user_name)
        if user
            signin
        else
            User.create(name: user_name)
            signin(new_user = true)
        end
    end

    def print_page_options(options)
        options.each_with_index do |option, index|
            puts "#{index+1}. #{option}"
        end
    end

    def user_page
        clear_console
        puts "Hello #{@logged_in_user.name}, welcome back."

        options = [
            'Create a recipe', 
            'View my saved recipes', 
            'Find a recipe', 
            'View my created recipes', 
            'Manage account', 
            'More', 
            'Logout', 
            'Quit'
        ]
        print_page_options(options)

        user_input = get_valid_input(options.length)

        case user_input
        when 1
            create_recipe            #DONE
        when 2
            view_saved_recipes       #DONE
        when 3
            find_a_recipe            #DONE
        when 4
            view_created_recipes     #DONE
        when 5
            manage_account           #DONE
        when 6
            more_options             #DONE
        when 7
            @logged_in_user = nil
            welcome_message          #DONE
        when 8
            clear_console
            abort("Thanks for using FoodLocker")
        end
    end

    def view_saved_recipes
        clear_console
        @logged_in_user.see_saved_recipes.each do |recipe|
            puts "*************"
            puts "name: #{recipe.name.colorize(:green)}"
            puts "description: #{recipe.description.colorize(:blue)}"
            puts "rating: " + "#{recipe.view_recipe_rating}".colorize(:green)
        end

        puts "*************"
        press_enter_to_go_back
    end

    def press_enter_to_go_back
        puts "----------------------"
        puts "Press Enter to go back"

        user_input = get_input
        if user_input.empty?
            user_page
        end
        user_input
    end

    def find_a_recipe(error = false)
        clear_console
        puts "Sorry, that recipe does not exist".colorize(:red) if error
        error = false
        puts "Please enter the name of a recipe"

        user_input = press_enter_to_go_back
        recipe = Recipe.find_by(name: user_input)
        # binding.pry
        if recipe
            view_recipe(recipe)
        else
            
            find_a_recipe(true)
        end
        
    end

    def clear_console
        75.times {puts ""}
    end

    def view_recipe(recipe)
        clear_console
        puts "NAME:" + " #{recipe.name}".colorize(:green)
        puts "RATING:" + " #{recipe.view_recipe_rating}".colorize(:green)
        puts "DESCRIPTION:"
        puts "#{recipe.description}".colorize(:blue)
        puts "---------------------"

        recipe_ingredients = recipe.recipe_ingredients
        recipe.ingredients.each_with_index do |ingredient, index|
            puts "#{ingredient.name}: #{recipe_ingredients[index].amount}"
        end

        remove_recipe = false
        options = ['Save recipe?', 'Go back']
        if !@logged_in_user.recipes.include?(recipe)
            options[0] = 'Save recipe?'
        else
            options[0] = 'Remove recipe from saved list?'
            remove_recipe = true
        end
        
        print_page_options(options)
        user_input = get_valid_input(options.length)
        case user_input
        when 1
            if !remove_recipe
                puts "Before saving, rate this recipe. Leave empty to skip"

                rating = get_input
                rating = 3 if rating.empty?
                @logged_in_user.save_recipe(recipe, rating.to_i)

                clear_console
                puts "Recipe saved successfully"
                press_enter_to_go_back
            else
                @logged_in_user.remove_saved_recipe(recipe)

                clear_console
                puts "Successfully removed recipe from saved recipes"
                press_enter_to_go_back
            end
        when 2
            user_page
        end
        
    end

    def create_recipe
        clear_console
        puts "Welcome, recipe creator!"
        puts "Please enter the name of your recipe"
        recipe_name = get_input

        clear_console
        puts "Please enter a description for your recipe"
        recipe_description = get_input

        clear_console
        puts "Please enter your Ingredients"
        puts "Use the correct format for ingredients".colorize(:red)
        puts "<INGREDIENT NAME>: <AMOUNT>".colorize(:green)
        puts ""
        puts "When done inputing ingredients, press enter to stop.".colorize(:red)
        ingredients = []
        # continue = true
        while true
            ingredient_string = get_input
            if ingredient_string.empty?
                break
            end
            ingredients_split = ingredient_string.split(': ')
            ingredients << {name: ingredients_split[0], amount: ingredients_split[1]}
        end
        recipe = @logged_in_user.create_recipe(recipe_name, recipe_description, ingredients)
        clear_console
        categories = []

        puts "Enter recipe categories. Leave empty to exit"
        while true
            category_name = get_input
            if category_name.empty?
                break
            end
            category = Category.find_or_create_by(title: category_name)
            RecipeCategory.create(category_id: category.id, recipe_id: recipe.id)
        end

        clear_console
        puts "Recipe created successfully"
        press_enter_to_go_back
    end

    def view_created_recipes
        clear_console
        puts "Average rating: " + "#{@logged_in_user.view_my_average_rating}".colorize(:green)
        puts "********************"

        @logged_in_user.created_recipes.each_with_index do |recipe, index|
            puts "#{index+1}."
            puts "NAME: " + "#{recipe.name}".colorize(:green)
            puts "RATING: " + "#{recipe.view_recipe_rating}".colorize(:green)
            puts "DESCRIPTION:"
            puts "#{recipe.description}".colorize(:blue)
            puts "*********************"
        end
        options = ['Edit a recipe', 'Go back']
        print_page_options(options)
        input = get_valid_input(options.length)
        case input
        when 1
            edit_a_recipe
        when 2
            user_page
        end
    end

    def edit_a_recipe
        clear_console
        puts "Please choose a recipe to edit:"

        recipes = @logged_in_user.created_recipes

        print_page_options(recipes.map {|recipe| recipe.name})
        input = get_valid_input(recipes.length)
        recipe = recipes[input-1]

        clear_console
        puts "Please enter a new name, or leave empty to skip"
        new_name = get_input
        recipe.name = new_name if !new_name.empty?

        puts "************"
        puts "Please enter a new description, or leave empty to skip"

        new_description = get_input
        recipe.description = new_description if !new_description.empty?
        @logged_in_user.edit_recipe(recipe, recipe.name, recipe.description)

        clear_console
        puts "Recipe edited successfully"
        press_enter_to_go_back
    end

    def more_options
        clear_console
        options = [
            'View recipes in my favorite categories', 
            "View recipes I've rated", 
            'View top category', 
            'View top rated recipe', 
            'Go back']
        print_page_options(options)
        input = get_valid_input(options.length)
        case input
        when 1
            view_recipes_in_category       #DONE
        when 2
            view_recipes_i_rated           #DONE
        when 3
            view_top_category              #DONE
        when 4
            view_top_rated_recipe          #DONE
        when 5
            user_page
        end
    end

    def view_recipes_in_category
        clear_console
        recipes = @logged_in_user.recipes_in_my_categories
        recipes.each do |recipe|
            puts "NAME: #{recipe}"
            # puts "RATING: #{recipe.view_recipe_rating}"
            # puts "DESCRIPTION:"
            # puts "#{recipe.description}"
            puts "..................."
        end
        press_enter_to_go_back
    end

    def view_recipes_i_rated
        clear_console
        recipes = @logged_in_user.my_rated_recipes
        recipes.each do |recipe_array|
            puts "NAME: #{recipe_array[0].colorize(:green)}, MY RATING: #{recipe_array[1].colorize(:green)}"
            puts "------------"
        end
        press_enter_to_go_back
    end

    def view_top_category
        clear_console
        puts "How many popular categories do you want to see?"
        input = get_input.to_i
        UserCategory.top_n_categories(input).each do |category|
            puts "Category Title: #{category.keys[0]}"
        end
        press_enter_to_go_back
    end

    def view_top_rated_recipe
        clear_console
        Recipe.see_top_rated_recipes.each_with_index do |recipe, index|
            puts "#{index+1}. NAME: #{recipe[0]} -- RATING: #{recipe[1]}"
        end
        press_enter_to_go_back
    end

    def manage_account
        clear_console
        options = [
            'Change User Name',
            'Add favorite category',
            'View my favorite categories',
            'Go back'
        ]
        print_page_options(options)
        input = get_valid_input(options.length)
        case input
        when 1
            change_name
        when 2
            add_fav_category
        when 3
            view_favorite_categories
        when 4
            user_page
        end
    end

    def view_favorite_categories
        clear_console
        @logged_in_user.categories.each do |category|
            puts "#{category.title}"
        end
        press_enter_to_go_back
    end

    def change_name
        clear_console
        puts "Please enter a new username"
        puts "---------------------------"

        input = get_input
        @logged_in_user.update(name: input)
        
        clear_console
        puts "Name updated successfully"
        puts "Your new username is: #{@logged_in_user.name}"
        press_enter_to_go_back
    end

    def add_fav_category
        clear_console
        my_categories = @logged_in_user.categories
        available_categories = Category.all.reject {|category| my_categories.include?(category)}

        puts "Your favorite categories are:"

        my_categories.each_with_index {|category, index| puts "#{index+1}. #{category.title}"}

        puts "-----------------"
        puts "These are the categories that are available:"
        print_page_options(available_categories.map{|category| category.title})
        puts "-----------------"

        puts "Please enter the number beside the category you want to add."

        input = get_valid_input(available_categories.length)-1
        UserCategory.create(user_id: @logged_in_user.id, category_id: available_categories[input].id)

        clear_console
        puts "You added the category: #{available_categories[input].title}."
        puts "-----------------"

        @logged_in_user.categories.each_with_index {|category, index| puts "#{index+1}. #{category.title}"}
        press_enter_to_go_back
    end

end