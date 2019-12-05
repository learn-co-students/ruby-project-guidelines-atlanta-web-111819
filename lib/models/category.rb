class Category < ActiveRecord::Base
    has_many :recipe_categories
    has_many :recipes, through: :recipe_categories
    has_many :user_categories
    has_many :users, through: :user_categories
end