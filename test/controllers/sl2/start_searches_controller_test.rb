require 'test_helper'

class Sl2::StartSearchesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_TWO)
    log_user_in(@user)
  end

  should "assign a ONE NEW ticket to the user" do
    t = create(:search_ticket, status: SearchTicket::STATUS_NEW)
    patch sl2_start_search_path, params: { search_ticket_ids: t.id }
    assert_redirected_to sl2_search_ticket_path(t)

    t.reload
    assert_equal t.assigned_to_id, @user.id
    assert_equal t.status, SearchTicket::STATUS_SEARCH_IN_PROGRESS
  end

  should "assign a ONE ESCALATED ticket to the user" do
    t = create(:search_ticket, status: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2)
    patch sl2_start_search_path, params: { search_ticket_ids: t.id }
    assert_redirected_to sl2_search_ticket_path(t)

    t.reload
    assert_equal t.assigned_to_id, @user.id
    assert_equal t.status, SearchTicket::STATUS_SEARCH_IN_PROGRESS
  end

  should "assing MULTIPLE NEW/ESCALATED tickets to the user" do
    t1 = create(:search_ticket, status: SearchTicket::STATUS_NEW)
    t2 = create(:search_ticket, status: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2)

    patch sl2_start_search_path, params: { search_ticket_ids: [t1.id, t2.id] }
    assert_redirected_to sl2_dashboard_path

    t1.reload
    assert_equal t1.assigned_to_id, @user.id
    assert_equal t1.status, SearchTicket::STATUS_SEARCH_IN_PROGRESS
    t2.reload
    assert_equal t2.assigned_to_id, @user.id
    assert_equal t2.status, SearchTicket::STATUS_SEARCH_IN_PROGRESS
  end


  should "NOT ALLOW assignement or Status change for any other ticket status" do
    t1 = create(:search_ticket, status: SearchTicket::STATUS_RESOLVED)
    t2 = create(:search_ticket, status: SearchTicket::STATUS_REVIEW_BY_COORDINATOR)

    patch sl2_start_search_path, params: { search_ticket_ids: [t1.id, t2.id] }
    assert_redirected_to sl2_dashboard_path

    t1.reload    
    assert t1.assigned_to_id != @user.id
    assert t1.status != SearchTicket::STATUS_SEARCH_IN_PROGRESS

    t2.reload
    assert t2.assigned_to_id != @user.id
    assert t2.status != SearchTicket::STATUS_SEARCH_IN_PROGRESS
  end


  ## Should that Check incoming items are of status new
  ## Should assign tickets to current user
  ## Should update status to Search_In_Progress
  #
  # should "check incoming items are status new or escalated" do
  #   # new_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_NEW)
  #
  #   in_progress_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
  #
  #   in_progress_tickets.each do |ipt|
  #     assert_not_equal SearchTicket::STATUS_ESCALATED_TO_LEVEL_2, ipt.status do
  #       assert_redirected_to sl2_dashboard_path
  #     end
  #   end
  #
  #
  # end
  #
  # should "update and assign user to tickets" do
  #   new_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2)
  #   search_ticket_ids_local = [];
  #
  #   new_tickets.each do |nt|
  #     assert_equal SearchTicket::STATUS_ESCALATED_TO_LEVEL_2, nt.status, "Precondition: Status must be = STATUS_ESCALATED_TO_LEVEL_2"
  #     search_ticket_ids_local.push(nt.id.to_s)
  #     # puts nt.status
  #   end
  #
  #
  # end

end
