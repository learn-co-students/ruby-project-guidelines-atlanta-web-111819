class CreateComics < ActiveRecord::Migration[5.0]
  def change
    create_table(:comics) do |t|
      t.integer :comic_id
      t.string :name
      t.string :release_date
      t.integer :issue_num
      t.string :description
    end
  end
end
