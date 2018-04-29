class CreateUserWallet < ActiveRecord::Migration[5.1]
  def change
    create_table :user_wallets do |t|
      t.integer :user_id
      t.integer :amount
      t.index :user_id
    end
  end
end
