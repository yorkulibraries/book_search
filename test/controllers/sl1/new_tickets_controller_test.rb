require 'test_helper'

class Sl1::NewTicketsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "show new search tickets" do
    new_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_NEW)
    other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_RESOLVED)

    get sl1_new_tickets_path
    assert_response :success

    assert_select ".search_ticket_status", { count: new_tickets.size, text: SearchTicket::STATUS_NEW}
    assert_select ".search_ticket_status", { count: 0, text: SearchTicket::STATUS_RESOLVED }
  end

end
