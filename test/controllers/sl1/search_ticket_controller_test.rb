require 'test_helper'

class Sl1::SearchTicketControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "display the details for a search ticket" do
    sr = create(:search_ticket)

    get sl1_search_ticket_path(sr)
    assert_response :success
    assert_select ".card-header span", "Search Ticket Details"
  end

  should "display the work log form if ticket has no search attemps, only for STATUS_SEARCH_IN_PROGRESS tickets" do
    sr = create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)

    get edit_sl1_search_ticket_path(sr)
    assert_response :success
    assert_select "h1", "Record Work Log"
  end

  should "add a new work log to the ticket, if none are present" do
    sr = create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)

    assert_equal 0, sr.work_logs.size , "Precodition: No Work Logs"
    assert_equal SearchTicket::STATUS_SEARCH_IN_PROGRESS, sr.status, "Precondition: Status = STATUS_SEARCH_IN_PROGRESS"

    assert_difference "SearchTicket::WorkLog.count", 1 do
      patch sl1_search_ticket_path(sr)
      assert_redirected_to sl1_search_ticket_path(sr)
    end

    sr.reload

    assert_equal 1, sr.work_logs.size
    assert_equal SearchTicket::STATUS_SEARCH_IN_PROGRESS, sr.status, "Status shouldn't change"
  end


  should "redirect to details page for EDIT and UPDATE actions if work log has been recorded or search ticket status is not STATUS_SEARCH_IN_PROGRESS" do
    sr = create(:search_ticket, status: SearchTicket::STATUS_NEW)
    sa = create(:work_log, search_ticket: sr)

    get edit_sl1_search_ticket_path(sr)
    assert_redirected_to sl1_search_ticket_path

    patch sl1_search_ticket_path(sr)
    assert_redirected_to sl1_search_ticket_path

    sr = create(:search_ticket, status: SearchTicket::STATUS_RESOLVED)
    get edit_sl1_search_ticket_path(sr)
    assert_redirected_to sl1_search_ticket_path

    patch sl1_search_ticket_path(sr)
    assert_redirected_to sl1_search_ticket_path
  end
end
