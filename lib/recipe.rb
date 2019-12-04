class Recipe < ActiveRecord::Base
    has_many :meals
    has_many :users, through: :meals
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients

    has_many :recipe_categories
    has_many :categories, through: :recipe_categories
    belongs_to :creator, :class_name => "User"


    def view_recipe_rating
        total = self.meals.sum{|meal| meal.rating}
        total.to_f/self.meals.count
    end

end