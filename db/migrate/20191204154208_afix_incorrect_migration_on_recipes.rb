class AfixIncorrectMigrationOnRecipes < ActiveRecord::Migration[5.0]
  def change
    change_column :recipes, :user_id, :string
    rename_column :recipes, :user_id, :creator_id
  end
end
