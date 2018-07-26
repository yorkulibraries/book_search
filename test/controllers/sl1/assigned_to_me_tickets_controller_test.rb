require 'test_helper'

class Sl1::AssignedToMeTicketsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "show new search tickets" do
    assigned_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS, assigned_to: @user)
    other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_RESOLVED, assigned_to:nil)

    get sl1_assigned_to_me_tickets_path
    assert_response :success

    assert_select "[data-assigned-ticket-id]", { count: assigned_tickets.size }
  end

  should "show record search result for search_in_progress" do
    assigned_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS, assigned_to: @user)
    other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_RESOLVED, assigned_to: @user)

    get sl1_assigned_to_me_tickets_path
    assert_response :success

    assert_select ".btn.btn-primary", { count: assigned_tickets.size, text: "Log Search Result"}

    assert_select ".btn.btn-info", { count: other_tickets.size, text: "View Search Result"}

  end

end
