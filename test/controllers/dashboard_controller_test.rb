require 'test_helper'

class DashboardControllerTest < ActionDispatch::IntegrationTest

  setup do
    @employee = create(:employee, role: Employee::ROLE_MANAGER)
    log_user_in(@employee)
  end

  should "be logged in" do
    get dashboard_url
    assert_response :success
  end
end
