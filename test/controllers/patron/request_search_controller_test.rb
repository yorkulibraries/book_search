require 'test_helper'

class Patron::RequestSearchControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get patron_request_search_show_url
    assert_response :success
  end

end
