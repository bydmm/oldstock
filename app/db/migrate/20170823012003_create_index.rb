class CreateIndex < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :ipad_token
    add_index :users, :android_token
    add_index :users, :apple_token
    add_index :users, :token
    add_index :game_archives, :game_id
    add_index :game_archives, :from
    add_index :game_archives, :user_id
    add_index :game_archives, [:game_id, :user_id]
  end
end
