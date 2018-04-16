require 'test_helper'

class Sl1::NewRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sl1_new_requests_url
    
    assert_response :success
  end

end
