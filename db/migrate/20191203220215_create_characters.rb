class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table(:characters) do |t|
      t.integer :char_id
      t.string :name
      t.string :desc
    end
  end
end
