require 'test_helper'

class MissingItemReports::AssignToEmployeeControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get missing_item_reports_assign_to_employee_create_url
    assert_response :success
  end

  test "should get destroy" do
    get missing_item_reports_assign_to_employee_destroy_url
    assert_response :success
  end

end
