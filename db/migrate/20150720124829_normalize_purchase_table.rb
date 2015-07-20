class NormalizePurchaseTable < ActiveRecord::Migration
  def up
    remove_column :purchases, :merchant_id
  end

  def down
    add_column :purchases, :merchant_id, :integer
  end
end
