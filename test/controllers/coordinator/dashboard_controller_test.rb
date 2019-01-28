require 'test_helper'

class Coordinator::DashboardControllerTest < ActionDispatch::IntegrationTest

    setup do
      @user = create(:employee, role: Employee::ROLE_COORDINATOR)
      @location = @user.location
      log_user_in(@user)
    end

    should "show escalated search tickets in user's location" do
      under_review_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_REVIEW_BY_COORDINATOR, location: @location)
      other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2)

      get coordinator_dashboard_path
      assert_response :success

      assert_select ".under_review_ticket_row", under_review_tickets.size
    end

    should "calculate status properly for TODAY in user's location" do
      # in different locations

      create_list(:search_ticket, 2)
      create_list(:search_ticket, 2, status:SearchTicket::STATUS_RESOLVED, created_at: Date.yesterday)

      # in user's location

      created_today = create_list(:search_ticket, 3, location: @location)
      resolved_today = create_list(:search_ticket,5, location: @location, status: SearchTicket::STATUS_RESOLVED, created_at: Date.yesterday)

      get coordinator_dashboard_path
      assert_response :success

      assert_select "[data-created-today='#{created_today.size}']", 1
      assert_select "[data-resolved-today='#{resolved_today.size}']", 1
    end

    should "calculate status properly for YESTERDAY" do
      # Other Locations
      create_list(:search_ticket, 2, created_at: Date.yesterday)
      create_list(:search_ticket,5, status: SearchTicket::STATUS_RESOLVED, updated_at: Date.yesterday)

      # User's location
      created_yesterday = create_list(:search_ticket, 3, created_at: Date.yesterday, location: @location)
      resolved_yesterday = create_list(:search_ticket,5, location: @location, status: SearchTicket::STATUS_RESOLVED, updated_at: Date.yesterday)

      get coordinator_dashboard_path
      assert_response :success

      assert_select "[data-created-yesterday='#{created_yesterday.size}']",1
      assert_select "[data-resolved-yesterday='#{resolved_yesterday.size}']", 1
    end

    should "calculate status properly for PAST 7 DAYS" do
      created_past_4_days = create_list(:search_ticket, 3, created_at: 4.days.ago, location: @location)
      created_past_7_days = create_list(:search_ticket, 3, created_at: 6.days.ago, location: @location)
      resolved_past_7_days = create_list(:search_ticket,5, created_at: 9.days.ago, location: @location, status: SearchTicket::STATUS_RESOLVED, updated_at: 3.days.ago)

      create_list(:search_ticket, 3, created_at: 1.month.ago, location: @location)
      create_list(:search_ticket, 5, created_at: 2.weeks.ago, location: @location, status: SearchTicket::STATUS_RESOLVED, updated_at: 31.days.ago)

      get coordinator_dashboard_path
      assert_response :success

      created_together = created_past_4_days.size + created_past_7_days.size
      assert_equal 6, created_together

      assert_equal created_together, @location.tickets.created_past_7_days.size

      assert_select "[data-created-past-7-days='#{created_together}']", 1
      assert_select "[data-resolved-past-7-days='#{resolved_past_7_days.size}']", 1
    end

end
