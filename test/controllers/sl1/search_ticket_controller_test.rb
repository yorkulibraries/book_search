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
    assert_select "[data-ticket-id]", { value: sr.id }
  end

  should "display the work log form only for STATUS_SEARCH_IN_PROGRESS tickets" do
    sr = create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)

    get edit_sl1_search_ticket_path(sr)
    assert_response :success
    assert_select "form#new_search_ticket_work_log", 1
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

  ### FLOW VALIDATION TESTS
  should "If Item Found: add a new work log to the ticket and change ticket status and resolution" do
    ticket = create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
    sa1 = create(:search_area)
    sa2 = create(:search_area)

    assert_difference "SearchTicket::WorkLog.count", 1 do
      assert_difference " SearchTicket::SearchedArea.count", 2 do
        patch sl1_search_ticket_path(ticket), params: { search_ticket_work_log:
          { found_location: "Test", result:  SearchTicket::WorkLog::RESULT_FOUND, note: "Some Note",
            search_area_ids: [sa1.id, sa2.id]
            } }
      end
      assert_redirected_to sl1_search_ticket_path(ticket)
    end

    ticket.reload

    assert_equal 1, ticket.work_logs.size
    assert_equal SearchTicket::STATUS_RESOLVED, ticket.status, "Status change to resovled"

    # check if worklog details were recorded well.
    wl = ticket.work_logs.first
    assert_equal wl.work_type, SearchTicket::WorkLog::WORK_TYPE_SEARCH
    assert_equal wl.result,  SearchTicket::WorkLog::RESULT_FOUND
    assert_equal @user.id, wl.employee_id, "Record who did the work"
    assert_not_nil wl.found_location, "Found location should be filled"
  end

  should "If Item Not Found, add a new work log to the ticket and change ticket status" do
    ticket = create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
    sa1 = create(:search_area)
    sa2 = create(:search_area)

    assert_difference "SearchTicket::WorkLog.count", 1 do
      assert_difference " SearchTicket::SearchedArea.count", 2 do
        patch sl1_search_ticket_path(ticket), params: { search_ticket_work_log:
          { result:  SearchTicket::WorkLog::RESULT_NOT_FOUND, note: "Some Note",
            search_area_ids: [sa1.id, sa2.id]
            } }
      end
      assert_redirected_to sl1_search_ticket_path(ticket)
    end

    ticket.reload

    assert_equal 1, ticket.work_logs.size
    assert_equal SearchTicket::STATUS_ESCALATED_TO_LEVEL_2, ticket.status, "Status change to ESCALATED"
    assert_equal SearchTicket::RESOLUTION_UNKNOWN, ticket.resolution, "Resolution shouldn't change"
    assert_nil ticket.assigned_to_id, "Ticket should have been unassigned"
  end

  ## ERROR VALIDATION TESTS

  should "not redirect to search ticket details if couldn't save progress" do
    ticket = create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
    sa1 = create(:search_area)
    sa2 = create(:search_area)

    assert_equal 0, ticket.work_logs.size , "Precodition: No Work Logs"
    assert_equal SearchTicket::STATUS_SEARCH_IN_PROGRESS, ticket.status, "Precondition: Status = STATUS_SEARCH_IN_PROGRESS"

    assert_difference "SearchTicket::WorkLog.count", 0 do
      assert_difference " SearchTicket::SearchedArea.count", 0 do
        patch sl1_search_ticket_path(ticket), params: { search_ticket_work_log:
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
        patch sl1_search_ticket_path(ticket), params: { search_ticket_work_log:
          { found_location: "Test", result:  SearchTicket::WorkLog::RESULT_FOUND, note: "Some Note",
            search_area_ids: []
            } }
      end
      assert_response :success, "Shouldn't redirect but show the form again"
    end
  end

end
