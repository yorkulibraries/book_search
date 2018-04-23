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

  ### FORM TESTS
  should "add a new work log to the ticket for Item that is FOUND" do
    ticket = create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
    sa1 = create(:search_area)
    sa2 = create(:search_area)

    assert_equal 0, ticket.work_logs.size , "Precodition: No Work Logs"
    assert_equal SearchTicket::STATUS_SEARCH_IN_PROGRESS, ticket.status, "Precondition: Status = STATUS_SEARCH_IN_PROGRESS"

    assert_difference "SearchTicket::WorkLog.count", 1 do
      assert_difference " SearchTicket::SearchedArea.count", 2 do
        patch sl1_search_ticket_path(ticket), params: { work_log:
          { found_location: "Test", result:  SearchTicket::WorkLog::RESULT_FOUND, note: "Some Note",
            search_area_ids: [sa1.id, sa2.id]
            } }
      end
      assert_redirected_to sl1_search_ticket_path(ticket)
    end

    ticket.reload

    assert_equal 1, ticket.work_logs.size
    assert_equal SearchTicket::STATUS_SEARCH_IN_PROGRESS, ticket.status, "Status shouldn't change"

    # check if worklog details were recorded well.
    wl = ticket.work_logs.first
    assert_equal wl.work_type, SearchTicket::WorkLog::WORK_TYPE_SEARCH
    assert_equal wl.result,  SearchTicket::WorkLog::RESULT_FOUND
    assert_equal @user.id, wl.employee_id, "Record who did the work"
    assert_not_nil wl.found_location, "Found location should be filled"
  end

  should "not redirect to search ticket details if couldn't save progress" do
    ticket = create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
    sa1 = create(:search_area)
    sa2 = create(:search_area)

    assert_equal 0, ticket.work_logs.size , "Precodition: No Work Logs"
    assert_equal SearchTicket::STATUS_SEARCH_IN_PROGRESS, ticket.status, "Precondition: Status = STATUS_SEARCH_IN_PROGRESS"

    assert_difference "SearchTicket::WorkLog.count", 0 do
      assert_difference " SearchTicket::SearchedArea.count", 0 do
        patch sl1_search_ticket_path(ticket), params: { work_log:
          { found_location: "Test", note: "Some Note",
            search_area_ids: [sa1.id, sa2.id]
            } }
      end
      assert_response :success, "Shouldn't redirect but show the form again"
    end
  end

  should "not redirect to search ticket details, if no searched areas were picked" do
    ticket = create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
    sa1 = create(:search_area)
    sa2 = create(:search_area)

    assert_equal 0, ticket.work_logs.size , "Precodition: No Work Logs"
    assert_equal SearchTicket::STATUS_SEARCH_IN_PROGRESS, ticket.status, "Precondition: Status = STATUS_SEARCH_IN_PROGRESS"

    assert_difference "SearchTicket::WorkLog.count", 0 do
      assert_difference " SearchTicket::SearchedArea.count", 0 do
        patch sl1_search_ticket_path(ticket), params: { work_log:
          { found_location: "Test", result:  SearchTicket::WorkLog::RESULT_FOUND, note: "Some Note",
            search_area_ids: []
            } }
      end
      assert_response :success, "Shouldn't redirect but show the form again"
    end
  end

end
