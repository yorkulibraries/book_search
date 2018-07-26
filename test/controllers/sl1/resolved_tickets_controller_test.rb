require 'test_helper'

class Sl1::ResolvedTicketsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "show resolved search tickets" do
    resolved_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_RESOLVED, assigned_to: @user)
    other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_NEW, assigned_to: @user)

    get sl1_resolved_tickets_path
    assert_response :success

    assert_select "[data-resolved-ticket-id]", { count: resolved_tickets.size }    
  end


end
