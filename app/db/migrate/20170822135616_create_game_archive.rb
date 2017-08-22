class CreateGameArchive < ActiveRecord::Migration[5.1]
  def change
    create_table :game_archives do |t|
      t.integer :game_id
      t.string :from
      t.string :user_id
      t.text :content
    end
  end
end
