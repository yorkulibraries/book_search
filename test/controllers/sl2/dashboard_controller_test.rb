require 'test_helper'

class Sl2::DashboardControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_TWO)
    log_user_in(@user)
  end

  should "show escalated search tickets" do
    escalated_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2, assigned_to: @user)
    other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_NEW, assigned_to: @user)

    get sl2_dashboard_path
    assert_response :success

    assert_select ".search_ticket_status", { count: escalated_tickets.size, text: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2}
    assert_select ".search_ticket_status", { count: 0, text: SearchTicket::STATUS_NEW }
  end


end
