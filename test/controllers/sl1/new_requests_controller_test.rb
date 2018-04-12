require 'test_helper'

class Sl1::NewRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sl1_new_search_requests_index_url
    assert_response :success
  end

end
