class CreateStockTransaction < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_transactions do |t|
      t.integer :payer_id
      t.integer :payee_id
      t.integer :stock_code
      t.integer :pay_type
      t.integer :amount, default: 0
      t.index :payer_id
      t.index :payee_id
      t.index :stock_code
      t.index :pay_type
      t.timestamps
    end
  end
end
