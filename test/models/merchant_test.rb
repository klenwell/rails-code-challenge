require 'test_helper'

class MerchantTest < ActiveSupport::TestCase

  test "should require name field" do
    assert merchants(:acme_skydiving).valid?

    merchants(:acme_skydiving).name = nil
    assert_invalid_record_field(merchants(:acme_skydiving), :name, "can't be blank")
  end

  test "should require address field" do
    assert merchants(:acme_skydiving).valid?

    merchants(:acme_skydiving).address = nil
    assert_invalid_record_field(merchants(:acme_skydiving), :address, "can't be blank")
  end

  test "should allow merchants with same name only if they have different addresses" do
    # Same address -> invalid
    merchants(:bobs_burgers).address = merchants(:the_other_bobs_burgers).address
    assert_invalid_record_field(merchants(:bobs_burgers), :name, 'has already been taken')

    # Different addresses -> valid
    merchants(:bobs_burgers).address = 'Ocean Ave.' # Duplicate matching not very sophisticated
    assert merchants(:bobs_burgers).valid?
  end

end
