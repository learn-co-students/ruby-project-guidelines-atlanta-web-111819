class User < ActiveRecord::Base
    has_many :meals
    has_many :recipes, through: :meals
    has_many :created_recipes, :class_name => "Recipe"
    has_many :user_categories
    has_many :categories, through: :user_categories
end