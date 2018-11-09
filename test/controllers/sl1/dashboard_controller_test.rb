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

  should "show new search and assigned tickets" do
    assigned_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS, assigned_to: @user)
    new_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_NEW)

    get sl1_dashboard_path
    assert_response :success

    assert_select "[data-new-tickets-count]", { value: new_tickets.size }
    assert_select "[data-assigned-tickets-count]", { value: assigned_tickets.size }
  end

end
