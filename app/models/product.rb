class Product < ActiveRecord::Base

  belongs_to :merchant

  validates :description, presence: true
  validates :price, presence: true

  # Allows products with same description so long as they belong to a different merchant.
  validates :description, uniqueness: {scope: :merchant_id}

end
