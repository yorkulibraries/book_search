require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  should "create a valid Patron" do
    assert_difference "Patron.count", 1 do
      patron = build(:patron)
      patron.save
    end
  end

  should "not create an invalid patron" do
    assert ! build(:patron, email: nil).valid?, "Email Address is required"
    assert ! build(:patron, name: nil).valid?, "Name is required"
    assert ! build(:patron, login_id: nil).valid?, "Login ID is required"

    patron = create(:patron)
    assert ! build(:patron, login_id: patron.login_id).valid?, "Should be invalid since patron with login is created already"
  end


end
