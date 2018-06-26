require 'test_helper'

class InvalidLoginControllerTest < ActionDispatch::IntegrationTest

  should "show invalid login page" do
    get invalid_login_url
    assert_response :success
  end

end
