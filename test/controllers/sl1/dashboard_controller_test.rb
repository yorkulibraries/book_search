require 'test_helper'

class Sl1::DashboardControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "display the details for a search ticket" do
    sr = create(:search_ticket)

    get sl1_dashboard_path
    assert_response :success
    assert_select "h1", "Dashboard"
  end

end
