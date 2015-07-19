require 'test_helper'

class PurchaserTest < ActiveSupport::TestCase

  test "should validate records correctly" do
    amy = purchasers(:amy)
    assert amy.valid?

    amy.name = ''
    assert_not amy.valid?
    assert_equal amy.errors.to_hash[:name].first, "can't be blank"

    amy.name = purchasers(:snake).name
    assert_not amy.valid?
    assert_equal amy.errors.to_hash[:name].first, 'has already been taken'
  end

end
