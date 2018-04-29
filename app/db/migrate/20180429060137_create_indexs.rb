class CreateIndexs < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :token
    add_index :stocks, :code
  end
end
