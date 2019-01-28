require 'test_helper'

class Sl2::DashboardControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_TWO)
    @location = @user.location
    log_user_in(@user)
  end

  should "display the details for a search ticket" do
    sr = create(:search_ticket)

    get sl2_dashboard_path
    assert_response :success
    assert_select "h2", "Dashboard"
  end

  should "show escalated search tickets" do
    escalated_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2, assigned_to: nil, location: @location)
    assigned_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS, assigned_to: @user, location: @location)
    other_tickets = create_list(:search_ticket, 4, status: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2)

    get sl2_dashboard_path
    assert_response :success

    assert_select ".escalated_ticket_row", escalated_tickets.size
    assert_select ".assigned_ticket_row",assigned_tickets.size
  end


end
