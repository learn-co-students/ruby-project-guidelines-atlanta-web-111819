class Recipe < ActiveRecord::Base
    has_many :meals
    has_many :users, through: :meals
    has_many :user_recipes
    has_many :users, through: :user_recipes
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    belongs_to :user
    # alias_attribute :user, :creator
end