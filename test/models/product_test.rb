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

  test "should create purchase when row data is valid" do
    row = {
      purchaser_name: 'Snake Plissken',
      item_description: '$10 off $20 of food',
      item_price: '10.0',
      purchase_count: '2',
      merchant_address: '987 Fake St',
      merchant_name: "Bob's Pizza"
    }

    assert_difference('Purchase.count', +1) do
      Purchase.create_from_uploaded_row!(row)
    end
  end

  test "should not create purchase when row data is invalid" do
    invalid_item_price = 'abc'

    row = {
      purchaser_name: 'Snake Plissken',
      item_description: '$10 off $20 of food',
      item_price: invalid_item_price,
      purchase_count: '2',
      merchant_address: '987 Fake St',
      merchant_name: "Bob's Pizza"
    }

    assert_raises(ActiveRecord::StatementInvalid) {
      Purchase.create_from_uploaded_row!(row)
    }
  end

end
