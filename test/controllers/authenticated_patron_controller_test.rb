require 'test_helper'

class AuthenticatedPatronControllerTest < ActionDispatch::IntegrationTest
  ## NOT TESTED


  should "employee be able to login to patron side of things" do
    e = create(:employee)
    log_user_in(e)
    get patron_my_tickets_url
    assert_response :success
  end
end
