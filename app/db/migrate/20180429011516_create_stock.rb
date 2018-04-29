class CreateStock < ActiveRecord::Migration[5.1]
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :code
      t.text :avatar
    end
  end
end
