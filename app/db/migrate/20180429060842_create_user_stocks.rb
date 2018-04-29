class CreateUserStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_stocks do |t|
      t.integer :user_id
      t.integer :stock_id
      t.integer :balance, default: 0
      t.index [:user_id, :stock_id], unique: true
    end
  end
end
