class Purchase < ActiveRecord::Base

  belongs_to :purchaser
  belongs_to :merchant
  belongs_to :product

  validates :purchaser, presence: true
  validates :merchant, presence: true
  validates :product, presence: true
  validates :count, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  before_save :compute_total_amount

  private

  def compute_total_amount
    self[:total_amount] = count * product.price
  end

end
