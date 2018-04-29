class CreateStockTransaction < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_transactions do |t|
      t.integer :payer
      t.integer :payee
      t.integer :stock_id
      t.integer :pay_type
      t.integer :amount
      t.index :payer
      t.index :payee
      t.index :stock_id
      t.index :pay_type
    end
  end
end
