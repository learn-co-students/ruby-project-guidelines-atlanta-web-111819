class Recipe < ActiveRecord::Base
    has_many :meals
    has_many :users, through: :meals
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients

    has_many :recipe_categories
    has_many :categories, through: :recipe_categories
    belongs_to :creator, :class_name => "User"


    def view_recipe_rating
        if self.meals.length == 0
            return 3
        end
        total = self.meals.sum{|meal| meal.rating}
        total.to_f/self.meals.count
    end

    def self.see_top_rated_recipes
        best_recipes = Recipe.all.sort do|recipe1, recipe2| 
            # binding.pry
            recipe2.view_recipe_rating <=> recipe1.view_recipe_rating 
        end
        # binding.pry
        recipes_and_ratings = best_recipes.map{|recipe| [recipe.name, recipe.view_recipe_rating]}
        recipes_and_ratings[0...10]
    end
    
    def self.search(name)
        Recipe.all.where('name = ?', name.capitalize).all
    end

end