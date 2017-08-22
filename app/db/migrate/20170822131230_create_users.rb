class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :from
      t.string :token
      t.string :uname
      t.string :ipad_token
      t.string :android_token
      t.string :apple_token
    end
  end
end
