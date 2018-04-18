require 'test_helper'

class LocationTest < ActiveSupport::TestCase

  should "create a valid Location" do
    assert_difference "Location.count", 1 do
      l = build(:location)
      l.save
    end
  end

  should "not create an invalid patron" do
    assert ! build(:location, email: nil).valid?, "Email Address is required"
    assert ! build(:location, name: nil).valid?, "Name is required"        
  end
end
