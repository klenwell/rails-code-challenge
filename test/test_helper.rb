ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "mocha/mini_test"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_invalid_record_field(record, field, message)
    assert_not record.valid?
    assert_equal record.errors.to_hash[field].first, message,
                 'Unexpected error message'
  end

  def sign_in
    ApplicationController.any_instance.stubs(:signed_in?).returns(true)
  end

  def sign_out
    ApplicationController.any_instance.stubs(:signed_in?).returns(false)
  end
end
