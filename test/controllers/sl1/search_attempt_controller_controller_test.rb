require 'test_helper'

class Sl1::SearchAttemptControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get sl1_search_attempt_controller_show_url
    assert_response :success
  end

end
