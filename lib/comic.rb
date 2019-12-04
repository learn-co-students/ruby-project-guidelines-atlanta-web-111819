class Comic < ActiveRecord::Base
    has_many :charactercomics
    has_many :characters, through: :charactercomics
end