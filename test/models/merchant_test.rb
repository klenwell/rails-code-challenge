require 'test_helper'

class MerchantTest < ActiveSupport::TestCase

  test "should require name field" do
    assert merchants(:acme_skydiving).valid?

    merchants(:acme_skydiving).name = nil
    assert_not merchants(:acme_skydiving).valid?
    assert_equal merchants(:acme_skydiving).errors.to_hash[:name].first, "can't be blank"
  end

  test "should require address field" do
    assert merchants(:acme_skydiving).valid?

    merchants(:acme_skydiving).address = nil
    assert_not merchants(:acme_skydiving).valid?
    assert_equal merchants(:acme_skydiving).errors.to_hash[:address].first, "can't be blank"
  end

  test "should allow merchants with same name only if they have different addresses" do
    # Same address -> invalid
    merchants(:bobs_burgers).address = merchants(:the_other_bobs_burgers).address
    assert_not merchants(:bobs_burgers).valid?
    assert_equal merchants(:bobs_burgers).errors.to_hash[:name].first, 'has already been taken'

    # Different addresses -> valid
    merchants(:bobs_burgers).address = 'Ocean Ave.' # Duplicate matching not very sophisticated
    assert merchants(:bobs_burgers).valid?
  end

end
