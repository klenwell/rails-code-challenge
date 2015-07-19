class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.integer :purchaser_id
      t.integer :merchant_id
      t.integer :product_id
      t.integer :count
      t.decimal :total_amount, precision: 12, scale: 2

      t.timestamps null: false
    end
    add_index :purchases, :purchaser_id
    add_index :purchases, :merchant_id
    add_index :purchases, :product_id
  end
end
