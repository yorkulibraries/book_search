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
    assert ! build(:employee, location: nil).valid?, "Location is required"

    employee = create(:employee)
    assert ! build(:employee, login_id: employee.login_id).valid?, "Should be invalid since patron with login is created already"

  end

  should "list tickets that are assinged to employee and within location" do
    e = create(:employee)
    assigned_in_location = create_list(:search_ticket, 2, location: e.location, assigned_to: e)
    assigned_not_in_location = create_list(:search_ticket, 2, assigned_to: e)
    not_assigned_same_locaiton = create_list(:search_ticket, 3, location: e.location)
    other_tickets = create_list(:search_ticket, 4)

    all = other_tickets.size + not_assigned_same_locaiton.size + assigned_in_location.size + assigned_not_in_location.size

    assert_equal SearchTicket.count, all
    assert_equal assigned_in_location.size, e.tickets_in_location.size
    assert_equal assigned_in_location.size + assigned_not_in_location.size, e.assigned_tickets.size

  end



end
