class User < ActiveRecord::Base
    has_many :meals
    has_many :recipes, through: :recipes
    has_many :user_recipes
    has_many :recipes, through: :user_recipes
    has_many :recipes
end