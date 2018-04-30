class CreateCoinTransaction < ActiveRecord::Migration[5.1]
  def change
    create_table :coin_transactions do |t|
      t.integer :payer_id
      t.integer :payee_id
      t.integer :pay_type
      t.integer :amount, default: 0
      t.index :payer_id
      t.index :payee_id
      t.index :pay_type
      t.timestamps
    end
  end
end
