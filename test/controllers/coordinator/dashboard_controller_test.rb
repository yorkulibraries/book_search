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

      assert_select "[data-under-review-tickets-count]", { value: under_review_tickets.size }
    end

    should "calculate status properly for TODAY" do
      today_created_tickets = create_list(:search_ticket, 3)
      today_resolved_tickets = create_list(:search_ticket,5, status: SearchTicket::STATUS_RESOLVED, created_at: Date.yesterday)

      get coordinator_dashboard_path
      assert_response :success

      assert_select "[data-created-today]", { value: today_created_tickets.size }
      assert_select "[data-resolved-today]", { value: today_resolved_tickets.size }
    end

    should "calculate status properly for YESTERDAY" do
      yesterday_created_tickets = create_list(:search_ticket, 3, created_at: Date.yesterday)
      yesterday_resolved_tickets = create_list(:search_ticket,5, status: SearchTicket::STATUS_RESOLVED, updated_at: Date.yesterday)

      get coordinator_dashboard_path
      assert_response :success

      assert_select "[data-created-yesterday]", { value: yesterday_created_tickets.size }
      assert_select "[data-resolved-yesterday]", { value: yesterday_resolved_tickets.size }
    end

    should "calculate status properly for PAST 7 DAYS" do
      past_4_days_created_tickets = create_list(:search_ticket, 3, created_at: 4.days.ago)
      past_7_days_created_tickets = create_list(:search_ticket, 3, created_at: 7.days.ago)
      past_7_days_resolved_tickets = create_list(:search_ticket,5, status: SearchTicket::STATUS_RESOLVED, updated_at: 3.days.ago)

      create_list(:search_ticket, 3, created_at: 1.month.ago)
      create_list(:search_ticket,5, status: SearchTicket::STATUS_RESOLVED, updated_at: 31.days.ago)

      get coordinator_dashboard_path
      assert_response :success

      assert_select "[data-created-past-7-days]", { value: past_4_days_created_tickets.size + past_7_days_created_tickets.size }
      assert_select "[data-resolved-past-7-days]", { value: past_7_days_resolved_tickets.size }
    end

end
