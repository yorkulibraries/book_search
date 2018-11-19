require 'test_helper'

class Sl1::TicketsByStatusControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "show search tickets with status UNKNOWN" do
    get sl1_tickets_by_status_path
    assert_response :success
    assert_select "[data-tickets-count]", { value: 0 }, "If no status is passed, not tickets should be displayed"
  end


  # ONLY THESE THREE STATUSES SHOULD BE SHOW TO THIS LEVEL
  [SearchTicket::STATUS_NEW, SearchTicket::STATUS_ESCALATED_TO_LEVEL_2, SearchTicket::STATUS_RESOLVED].each do |status|
    should "show search tickets with different statuses - #{status}" do
      tickets = create_list(:search_ticket, 2, status: status)
      get sl1_tickets_by_status_path(status: status)
      assert_response :success
      assert_select "[data-tickets-count]", { value: tickets.size }
    end
  end

  should "limit the number of recently resovled to 100" do

    tickets = create_list(:search_ticket, 101, status: status)
    get sl1_tickets_by_status_path(status: SearchTicket::STATUS_RESOLVED)
    assert_response :success
    assert_select "[data-tickets-count]", { value: 100 }
  end

end
