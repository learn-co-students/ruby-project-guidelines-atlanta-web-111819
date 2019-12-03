class CreateCharactercomics < ActiveRecord::Migration[5.0]
  def change
    create_table(:charactercomics) do |t|
      t.integer :character_id
      t.integer :comic_id
    end
  end
end
