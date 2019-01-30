require 'test_helper'

class Manager::EmployeesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get manager_employees_show_url
    assert_response :success
  end

end
