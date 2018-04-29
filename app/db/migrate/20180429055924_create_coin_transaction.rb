class CreateCoinTransaction < ActiveRecord::Migration[5.1]
  def change
    create_table :coin_transactions do |t|
      t.integer :payer
      t.integer :payee
      t.integer :stock_id
      t.integer :pay_type
      t.integer :amount
      t.index :payer
      t.index :payee
      t.index :pay_type
    end
  end
end
