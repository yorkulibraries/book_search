require 'test_helper'

class Sl1::MySearchTicketsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "show new search tickets" do
    assigned_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS, assigned_to: @user)
    other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_RESOLVED, assigned_to: @user)

    get sl1_my_search_tickets_path
    assert_response :success

    assert_select ".search_ticket_status", { count: assigned_tickets.size, text: SearchTicket::STATUS_SEARCH_IN_PROGRESS}
    assert_select ".search_ticket_status", { count: other_tickets.size, text: SearchTicket::STATUS_RESOLVED }
  end
  
  should "show record search result for search_in_progress" do
    assigned_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS, assigned_to: @user)
    other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_RESOLVED, assigned_to: @user)

    get sl1_my_search_tickets_path
    assert_response :success
    
    assert_select ".action_buttons", { count: assigned_tickets.size, text: "Record Search Result"} 
    
    assert_select ".action_buttons", { count: other_tickets.size, text: "View Search Result"}
    
  end

end
