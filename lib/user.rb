class User < ActiveRecord::Base
    has_many :meals
    has_many :recipes, through: :meals
    has_many :created_recipes, :class_name => "Recipe",:foreign_key => "creator_id" # tells users to use a given column name
    has_many :user_categories
    has_many :categories, through: :user_categories

    def save_recipe(recipe, rating = nil)
        if rating > 5 && rating != nil
            rating = 5
        elsif rating < 1 && rating != nil 
            rating = 1 
        end 
        meal = Meal.find_or_create_by(user_id: self.id, recipe_id: recipe.id)
        meal.rating = rating
        meal.save
    end 

    def see_saved_recipes
        self.recipes
    end

    def recipes_in_my_categories
        recipes = self.categories.map{ |category| category.recipes.map{|recipe| recipe.name}}
        recipes.flatten
    end

    def create_recipe(name, description, ingredients)
        new_recipe = Recipe.create(name: name, description: description, creator_id: self.id)
        create_recipe_ingredients(self.create_ingredients(ingredients), new_recipe)
    end

    def create_ingredients(ingredients)
        ingredients.map do |ingredient| 
            {ingredient: Ingredient.find_or_create_by(name: ingredient[:name]),
            amount: ingredient[:amount]}
        end 
    end

    def create_recipe_ingredients(ingredients_data, new_recipe)
        ingredients_data.each do |ingredient| 
            RecipeIngredient.create(recipe_id: new_recipe.id, ingredient_id: ingredient[:ingredient].id,amount: ingredient[:amount])
        end 
    end

    def rate_recipe(recipe, rating)
        if rating > 5
            rating = 5
        elsif rating < 1
            rating = 1 
        end 
        meal1 = Meal.find_or_create_by(user_id: self.id, recipe_id: recipe.id)
        meal1.update(rating: rating)
    end

    def edit_recipe(recipe, recipe_name, description)
        recipe.update(name: recipe_name, description: description)
    end

    def remove_saved_recipe(recipe)
        meal1 = Meal.find_by(recipe_id: recipe.id)
        meal1.destroy
    end



























end