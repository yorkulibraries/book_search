require 'test_helper'

class Manager::DashboardControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_MANAGER)
    log_user_in(@user)
  end

  context "in all locations" do

    should "calculate status properly for TODAY " do
      created_today = create_list(:search_ticket, 3)
      resolved_today = create_list(:search_ticket,5, status: SearchTicket::STATUS_RESOLVED, created_at: Date.yesterday)

      get manager_dashboard_path
      assert_response :success

      assert_select "[data-created-today='#{created_today.size}']", 1
      assert_select "[data-resolved-today='#{resolved_today.size}']", 1
    end

    should "calculate status properly for YESTERDAY" do
    
      # User's location
      created_yesterday = create_list(:search_ticket, 3, created_at: Date.yesterday)
      resolved_yesterday = create_list(:search_ticket,5, status: SearchTicket::STATUS_RESOLVED, updated_at: Date.yesterday)

      get manager_dashboard_path
      assert_response :success

      assert_select "[data-created-yesterday='#{created_yesterday.size}']",1
      assert_select "[data-resolved-yesterday='#{resolved_yesterday.size}']", 1
    end

    should "calculate status properly for PAST 7 DAYS" do
      created_past_4_days = create_list(:search_ticket, 3, created_at: 4.days.ago)
      created_past_7_days = create_list(:search_ticket, 3, created_at: 6.days.ago)
      resolved_past_7_days = create_list(:search_ticket,5, created_at: 9.days.ago, status: SearchTicket::STATUS_RESOLVED, updated_at: 3.days.ago)

      create_list(:search_ticket, 3, created_at: 1.month.ago)
      create_list(:search_ticket, 5, created_at: 2.weeks.ago, status: SearchTicket::STATUS_RESOLVED, updated_at: 31.days.ago)

      get manager_dashboard_path
      assert_response :success

      created_together = created_past_4_days.size + created_past_7_days.size
      assert_equal 6, created_together

      assert_equal created_together, SearchTicket.created_past_7_days.size

      assert_select "[data-created-past-7-days='#{created_together}']", 1
      assert_select "[data-resolved-past-7-days='#{resolved_past_7_days.size}']", 1
    end
  end
end
