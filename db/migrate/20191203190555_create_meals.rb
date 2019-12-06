class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.integer :user_id
      t.integer :recipe_id
      t.integer :rating
    end
  end
end
