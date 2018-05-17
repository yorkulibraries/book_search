require 'test_helper'

class Print::TicketsToSearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get print_tickets_to_search_url
    assert_response :success
  end

end
