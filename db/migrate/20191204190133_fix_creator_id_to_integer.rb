class FixCreatorIdToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :recipes, :creator_id, :integer
  end
end
