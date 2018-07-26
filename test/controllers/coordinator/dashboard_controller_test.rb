require 'test_helper'

class Coordinator::DashboardControllerTest < ActionDispatch::IntegrationTest

    setup do
      @user = create(:employee, role: Employee::ROLE_COORDINATOR)
      log_user_in(@user)
    end

    should "show escalated search tickets" do
      under_review_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_REVIEW_BY_COORDINATOR)
      other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2)

      get coordinator_dashboard_path
      assert_response :success

      assert_select "[data-under-review-ticket-id]", { count: under_review_tickets.size }
    end

end
