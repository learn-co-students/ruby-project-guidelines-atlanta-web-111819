class Character < ActiveRecord::Base
    has_many :charactercomics
    has_many :comics, through: :charactercomics
end