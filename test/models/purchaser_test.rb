require 'test_helper'

class PurchaserTest < ActiveSupport::TestCase

  test "should validate records correctly" do
    amy = purchasers(:amy)
    assert amy.valid?

    amy.name = ''
    assert_invalid_record_field(amy, :name, "can't be blank")

    amy.name = purchasers(:snake).name
    assert_invalid_record_field(amy, :name, 'has already been taken')
  end

end
