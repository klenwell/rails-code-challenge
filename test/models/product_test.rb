require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "should require description field" do
    burger_special = products(:bobs_burger_special)
    assert burger_special.valid?

    burger_special.description = nil
    assert_invalid_record_field(burger_special, :description, "can't be blank")
  end

  test "should require price field" do
    products(:bobs_burger_special).price = nil
    assert_invalid_record_field(products(:bobs_burger_special), :price, "can't be blank")
  end

  test "should allow products with same description only if they belong to different merchants" do
    # Same merchant, same description -> invalid
    bobs_duplicate_burger_special = products(:bobs_burger_special).dup
    assert_invalid_record_field(bobs_duplicate_burger_special, :description,
                                'has already been taken')

    # Same merchant, same description, different prices -> invalid
    bobs_duplicate_burger_special = products(:bobs_burger_special).dup
    bobs_duplicate_burger_special.price = products(:bobs_burger_special).price - 1
    assert_invalid_record_field(bobs_duplicate_burger_special, :description,
                                'has already been taken')

    # Different merchants, same description -> valid
    other_bobs_burger_special = products(:other_bobs_burger_special)
    other_bobs_burger_special.description = products(:bobs_burger_special).description
    other_bobs_burger_special.price = products(:bobs_burger_special).price
    assert other_bobs_burger_special.valid?
  end

end
