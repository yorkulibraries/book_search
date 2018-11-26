require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @cas_login_id = SessionsController::CAS_LOGIN_ID
    @cas_first_name = SessionsController::CAS_FIRST_NAME
    @cas_last_name = SessionsController::CAS_LAST_NAME
    @cas_email = SessionsController::CAS_EMAIL

    @employee = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    @patron = create(:patron)
  end

  ###### Basic tests to test login and redirection #######

  # should "redirect to invalid login if user is not found" do
  #   get login_url, headers: {"#{@cas_login_id}" => "something random that don't exist" }
  #   assert_response :redirect
  #   assert_redirected_to invalid_login_url
  # end

  should "log in employee user" do
    get login_url, headers: { "#{@cas_login_id}" => @employee.login_id }
    assert_response :redirect
    assert_equal @employee.login_id, session[:login_id]
    assert_equal @employee.id, session[:user_id]
    assert_equal @employee.class.name, session[:user_type]
  end

  should "login patron user" do
    get login_url, headers: { "#{@cas_login_id}" => @patron.login_id }
    assert_response :redirect
    assert_equal @patron.login_id, session[:login_id]
    assert_equal @patron.id, session[:user_id]
    assert_equal @patron.class.name, session[:user_type]
  end

  #### MORE SPECIFIC TESTS ####

  should "create a Patron record if user is not found in the employee or patron fields" do
    patron = build(:patron)
    headers = {
      @cas_login_id => patron.login_id,
      @cas_first_name => patron.name.split(" ").first,
      @cas_last_name => patron.name.split(" ").last,
      @cas_email => patron.email
    }

    assert_difference "Patron.count", 1 do
      get login_url, headers: headers
      assert_response :redirect
      assert_redirected_to patron_my_tickets_path
    end

    p = Patron.find_by_login_id(patron.login_id)
    assert_not_nil p
    assert_equal p.name, patron.name
    assert_equal p.email, patron.email

  end

  context "Patron" do
    should "Not be able to see coordinator pages, even if they have the same id" do
      @patron.id = 1; @patron.save
      @employee.id = 1; @employee.save

      get login_url, headers: { "#{@cas_login_id}" => @patron.login_id }
      assert_response :redirect
      assert_redirected_to root_url

      get coordinator_dashboard_url
      assert_response :redirect
      #assert_redirected_to root_url

    end
  end

end
