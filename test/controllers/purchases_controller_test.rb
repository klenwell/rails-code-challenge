require 'test_helper'

class PurchasesControllerTest < ActionController::TestCase
  test "should display index page with upload form" do
    get :index
    assert_response :success
  end

  test "should display error message when no file submitted" do
    post :upload
    assert_response :redirect
    assert_equal 'Please submit a file.', flash[:alert]
  end

  test "should save data when valid tab file uploaded and display total revenue" do
  end

  test "should not save data when file with invalid data uploaded" do
  end
end
