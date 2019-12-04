class GivingMealADefaultRating < ActiveRecord::Migration[5.0]
  def change
    change_column_default :meals, :rating, 3

  end
end
