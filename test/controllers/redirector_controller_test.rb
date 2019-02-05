require 'test_helper'

class RedirectorControllerTest < ActionDispatch::IntegrationTest

  setup do
    @sl1 = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    @sl2 = create(:employee, role: Employee::ROLE_LEVEL_TWO)
    @coordinator = create(:employee, role: Employee::ROLE_COORDINATOR)
    @manager = create(:employee, role: Employee::ROLE_MANAGER)
    @patron = create(:patron)
  end

  should "redirect to login page if session[:user_type] is not present" do
    get root_url
    assert_redirected_to login_url
  end

  should "redirect to SL1 dashboard if user is Employee and SL1" do
    log_user_in(@sl1)
    get root_url
    assert_redirected_to sl1_dashboard_path
  end

  should "redirect to SL2 dashboard if user is Employee and SL2" do
    log_user_in(@sl2)
    get root_url
    assert_redirected_to sl2_dashboard_path
  end

  should "redirect to MANAGER dashboard if user is Employee and MANAGER" do
    log_user_in(@manager)
    get root_url
    assert_redirected_to manager_dashboard_path
  end

  should "redirect to SL1 dashboard if user is Employee and COORDINATOR" do
    log_user_in(@coordinator)
    get root_url
    assert_redirected_to coordinator_dashboard_path
  end

  should "redirect to redirect_to_url if it's present in the session" do
    get root_url,  params: { redirect_to_url:  sl2_dashboard_path }
    assert_redirected_to sl2_dashboard_path
    assert_nil session[:redirect_to_url]
  end

end
