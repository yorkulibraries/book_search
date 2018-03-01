require 'test_helper'

class SearchRequests::AssignToEmployeeControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get search_requests_assign_to_employee_create_url
    assert_response :success
  end

  test "should get destroy" do
    get search_requests_assign_to_employee_destroy_url
    assert_response :success
  end

end
