require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase

  def setup
    @burgers_for_snake = purchases(:burgers_for_snake)
  end

  def teardown
    @burgers_for_snake = nil
  end

  test "should be valid purchase" do
    assert @burgers_for_snake.valid?
  end

  test "that purchases require merchant" do
    @burgers_for_snake.merchant_id = nil
    assert_not @burgers_for_snake.valid?
    assert_equal @burgers_for_snake.errors.to_hash[:merchant].first, "can't be blank"
  end

  test "that purchases require purchaser" do
    @burgers_for_snake.purchaser_id = nil
    assert_not @burgers_for_snake.valid?
    assert_equal @burgers_for_snake.errors.to_hash[:purchaser].first, "can't be blank"
  end

  test "that purchases require product" do
    @burgers_for_snake.product_id = nil
    assert_not @burgers_for_snake.valid?
    assert_equal @burgers_for_snake.errors.to_hash[:product].first, "can't be blank"
  end

  test "should validate purchase count" do
    @burgers_for_snake.count = nil
    assert_not @burgers_for_snake.valid?
    assert_equal @burgers_for_snake.errors.to_hash[:count].first, "can't be blank"

    @burgers_for_snake.count = 'abc'
    assert_not @burgers_for_snake.valid?
    assert_equal @burgers_for_snake.errors.to_hash[:count].first, 'is not a number'

    @burgers_for_snake.count = 0
    assert_not @burgers_for_snake.valid?
    assert_equal @burgers_for_snake.errors.to_hash[:count].first, 'must be greater than or equal to 1'

    @burgers_for_snake.count = 1
    assert @burgers_for_snake.valid?
  end

  test "should compute total amount before save" do
    # Not computed before save
    new_deal = @burgers_for_snake.dup
    new_deal.count = 10
    assert new_deal.total_amount.nil?

    # Saving record invokes callback
    new_deal.save!
    assert_equal 20.00, new_deal.total_amount, 'Total amount not computed correctly'

    # If record updated, should recompute
    new_deal.count = 20
    new_deal.save!
    assert_equal 40.00, new_deal.total_amount, 'Total amount not computed correctly'
  end

end
