class User < ActiveRecord::Base
    has_many :meals
    has_many :recipes, through: :meals
    # has_many :user_recipes
    # has_many :recipes, through: :user_recipes
    # alias_attribute :recipes, :created_recipes
    has_many :created_recipes, :class_name => "Recipe"
end