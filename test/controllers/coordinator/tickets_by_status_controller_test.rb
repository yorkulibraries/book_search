require 'test_helper'

class Coordinator::TicketsByStatusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:employee, role: Employee::ROLE_COORDINATOR)
    @location = @user.location
    log_user_in(@user)
  end

  should "show search tickets with status UNKNOWN" do
    get coordinator_tickets_by_status_path
    assert_response :success
    assert_select "[data-tickets-count='0']", true, "If no status is passed, not tickets should be displayed"
  end


  SearchTicket::STATUSES.each do |status|
    should "show search tickets with different statuses - #{status}" do
      tickets = create_list(:search_ticket, 2, status: status, location: @location)
      get coordinator_tickets_by_status_path(status: status)
      assert_response :success
      assert_select "[data-tickets-count='#{tickets.size}']"
    end

    should "show search tickets with paging - #{status}" do
      tickets = create_list(:search_ticket, 12, status: status, location: @location)
      get coordinator_tickets_by_status_path(status: status)
      assert_response :success
      ## PAGING SET AT 6/page. Thefore only 2 pages for 12 tickets
      assert_select "ul.pagination li", 4 # 1,2,Next,Last
    end

    should "show search tickets but without paging if count is < 6" do
      tickets = create_list(:search_ticket, 5, status: status)
      get coordinator_tickets_by_status_path(status: status)
      assert_response :success

      ## paging check == none
      assert_select "ul.pagination", false
    end
  end

end
