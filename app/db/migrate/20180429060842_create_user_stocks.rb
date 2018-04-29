class CreateUserStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_stocks do |t|
      t.integer :user_id
      t.integer :stock_id
      t.integer :amount
      t.index :user_id
      t.index :stock_id
    end
  end
end
