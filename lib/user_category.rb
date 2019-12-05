class UserCategory < ActiveRecord::Base
    belongs_to :category
    belongs_to :user

    def self.top_n_categories(limit)
        counts = {}
        UserCategory.all.each do |user_category|
            if counts[user_category.category_id] == nil
                counts[user_category.category_id] = 1
            else
                counts[user_category.category_id] += 1
            end
        end
        names_and_counts = counts.map {|key, value| {Category.find(key).title => value}}
        names_and_counts.sort! {|category_count1, category_count2| category_count2.values[0] <=> category_count1.values[0]}
        names_and_counts[0...limit]
    end

    def self.top_category
        self.top_n_categories(1)
    end
end