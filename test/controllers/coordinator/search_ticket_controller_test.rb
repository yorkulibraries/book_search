require 'test_helper'

class Coordinator::SearchTicketControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_COORDINATOR)
    log_user_in(@user)
  end

  should "display the details for a search ticket" do
    ticket = create(:search_ticket)

    get coordinator_search_ticket_path(ticket)
    assert_response :success
    assert_select ".card-header .ticket-item-title", ticket.item_title
  end


  should "change status to resovled and record a worklog if sending to acquisitions" do
    ticket = create(:search_ticket, status: SearchTicket::STATUS_REVIEW_BY_COORDINATOR)

    assert_difference "SearchTicket::WorkLog.count", 1 do
      put coordinator_search_ticket_path(ticket), params: { acquisitions: true }
      assert_response :redirect
      assert_redirected_to coordinator_search_ticket_path(ticket)
    end

    ticket.reload

    assert_equal SearchTicket::STATUS_RESOLVED, ticket.status
    assert_equal SearchTicket::RESOLUTION_IN_ACQUISITIONS, ticket.resolution
    assert_nil ticket.assigned_to

    log = ticket.work_logs.last

    assert_equal SearchTicket::WorkLog::RESULT_SENT_TO_ACQUISITIONS, log.result
    assert_equal SearchTicket::WorkLog::WORK_TYPE_REVIEW, log.work_type
    assert_equal "Coordinator sent this SearchTicket to Acquisitions department", log.note


  end

  should "change status to ESCALATED_TO_LEVEL_2 and record a worklog if requestion another search" do
    ticket = create(:search_ticket, status: SearchTicket::STATUS_REVIEW_BY_COORDINATOR)

    assert_difference "SearchTicket::WorkLog.count", 1 do
      put coordinator_search_ticket_path(ticket), params: { search_again: true }
      assert_response :redirect
      assert_redirected_to coordinator_search_ticket_path(ticket)
    end

    ticket.reload

    assert_equal SearchTicket::STATUS_ESCALATED_TO_LEVEL_2, ticket.status
    assert_nil ticket.resolution
    assert_nil ticket.assigned_to

    log = ticket.work_logs.last

    assert_equal SearchTicket::WorkLog::RESULT_ANOTHER_SEARCH_REQUESTED, log.result
    assert_equal SearchTicket::WorkLog::WORK_TYPE_REVIEW, log.work_type
    assert_equal "Coordinator requested another search for this SearchTicket", log.note


  end


  should "not do anything to tickets that are do not have STATUS_REVIEW_BY_COORDINATOR as status" do
    ticket = create(:search_ticket, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)

    assert_no_difference "SearchTicket::WorkLog.count" do
      put coordinator_search_ticket_path(ticket)
      assert_redirected_to coordinator_search_ticket_path(ticket)
      ticket.reload
      assert_equal SearchTicket::STATUS_SEARCH_IN_PROGRESS, ticket.status, "Status hasn't changged"
    end


  end
end
