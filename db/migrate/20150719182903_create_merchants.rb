class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :address

      t.timestamps null: false
    end
    add_index :merchants, :name
  end
end
