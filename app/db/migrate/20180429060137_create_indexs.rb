class CreateIndexs < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :token, unique: true
    add_index :stocks, :code, unique: true
  end
end
