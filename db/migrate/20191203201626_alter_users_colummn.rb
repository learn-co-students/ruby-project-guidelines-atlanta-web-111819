class AlterUsersColummn < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, "CreateUsers", :name
  end
end
