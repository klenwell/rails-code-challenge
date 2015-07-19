class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :merchant_id
      t.string :description
      t.decimal :price, precision: 10, scale: 2

      t.timestamps null: false
    end
    add_index :products, :merchant_id
    add_index :products, :description
  end
end
