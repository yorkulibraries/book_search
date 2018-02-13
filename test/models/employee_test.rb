require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  should "create a valid Employee" do
    assert_difference "Employee.count", 1 do
      employee = build(:employee)
      employee.save
    end
  end

  should "not create an invalid Employee" do
    assert ! build(:employee, email: nil).valid?, "Email Address is required"
    assert ! build(:employee, name: nil).valid?, "Name is required"
    assert ! build(:employee, login_id: nil).valid?, "Login ID is required"
    assert ! build(:employee, role: nil).valid?, "Role is required"
    # assert ! build(:employee, location: nil).valid?, "Location is required"

    employee = create(:employee)
    assert ! build(:employee, login_id: employee.login_id).valid?, "Should be invalid since patron with login is created already"

  end


end
