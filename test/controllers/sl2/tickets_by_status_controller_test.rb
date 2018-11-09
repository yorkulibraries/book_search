require 'test_helper'

class Sl2::TicketsByStatusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_TWO)
    log_user_in(@user)
  end

  should "show search tickets with status UNKNOWN" do
    get sl2_tickets_by_status_path
    assert_response :success
    assert_select "[data-tickets-count]", { value: 0 }, "If no status is passed, not tickets should be displayed"
  end


  SearchTicket::STATUSES.each do |status|
    should "show search tickets with different statuses - #{status}" do
      tickets = create_list(:search_ticket, 2, status: status)
      get sl2_tickets_by_status_path(status: status)
      assert_response :success
      assert_select "[data-tickets-count]", { value: tickets.size }
    end
  end









end
