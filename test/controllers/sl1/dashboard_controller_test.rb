require 'test_helper'

class Sl1::DashboardControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "display the details for a search ticket" do
    sr = create(:search_ticket)

    get sl1_dashboard_path
    assert_response :success
    assert_select "h2", "Dashboard"
  end

  should "show new search and assigned tickets for employee's location only" do
    location = @user.location
    assigned_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS, assigned_to: @user, location: location)
    new_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_NEW, location: location)
    other_tickets = create_list(:search_ticket, 4, status: SearchTicket::STATUS_NEW)

    get sl1_dashboard_path
    assert_response :success

    assert_select ".new_ticket_row", new_tickets.size
    assert_select ".assigned_ticket_row", assigned_tickets.size
  end

end
