require 'test_helper'

class Print::TicketsToSearchControllerTest < ActionDispatch::IntegrationTest

  setup do
    @employee = create(:employee)
    log_user_in(@employee)
  end


  test "should get index" do
    get print_tickets_to_search_url
    assert_response :success
  end

end
