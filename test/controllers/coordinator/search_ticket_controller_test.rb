require 'test_helper'

class Coordinator::SearchTicketControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_COORDINATOR)
    log_user_in(@user)
  end

  should "display the details for a search ticket" do
    sr = create(:search_ticket)

    get coordinator_search_ticket_path(sr)
    assert_response :success
    assert_select ".card-header .ticket-item-title", sr.item_title
  end

end
