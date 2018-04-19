require 'test_helper'

class Sl1::InProgressTicketsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "show in progress search tickets" do
    in_progress_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS, assigned_to: @user)
    other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_RESOLVED, assigned_to: @user)

    get sl1_in_progress_tickets_path
    assert_response :success

    assert_select ".search_ticket_status", { count: in_progress_tickets.size, text: SearchTicket::STATUS_SEARCH_IN_PROGRESS}
    assert_select ".search_ticket_status", { count: 0, text: SearchTicket::STATUS_RESOLVED }
  end


end
