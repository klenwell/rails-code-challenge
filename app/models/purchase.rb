class Purchase < ActiveRecord::Base

  belongs_to :purchaser
  belongs_to :product

  validates :purchaser, presence: true
  validates :product, presence: true
  validates :count, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  before_save :compute_total_amount

  def self.create_from_uploaded_row!(row)
    # Find or create associated model records. Any invalid fields will raise an error
    # that will be caught by transaction block.
    merchant = Merchant.where(name: row[:merchant_name],
                             address: row[:merchant_address]).first_or_create

    product = Product.where(description: row[:item_description],
                            price: row[:item_price],
                            merchant_id: merchant.id).first_or_create

    purchaser = Purchaser.where(name: row[:purchaser_name]).first_or_create

    # Now we can create the new purchase record
    return Purchase.create!(count: row[:purchase_count],
                            product_id: product.id,
                            purchaser_id: purchaser.id)
  end

  private

  def compute_total_amount
    self[:total_amount] = count * product.price
  end

end
