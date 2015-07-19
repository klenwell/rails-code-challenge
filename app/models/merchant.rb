class Merchant < ActiveRecord::Base

  has_many :products

  validates :name, presence: true
  validates :address, presence: true

  # Allows merchants with the same name so long as they have different addresses.
  validates :name, uniqueness: {scope: :address}

end
