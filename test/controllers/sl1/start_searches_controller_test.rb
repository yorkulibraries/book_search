require 'test_helper'

class Sl1::StartSearchesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "assign a ONE NEW ticket to the user" do
    t = create(:search_ticket, status: SearchTicket::STATUS_NEW)
    patch sl1_start_search_path, params: { search_ticket_ids: t.id }
    assert_redirected_to sl1_search_ticket_path(t)

    t.reload
    assert_equal t.assigned_to_id, @user.id
    assert_equal t.status, SearchTicket::STATUS_SEARCH_IN_PROGRESS
  end


  should "assing MULTIPLE NEW/ESCALATED tickets to the user" do
    t1 = create(:search_ticket, status: SearchTicket::STATUS_NEW)
    t2 = create(:search_ticket, status: SearchTicket::STATUS_NEW)

    patch sl1_start_search_path, params: { search_ticket_ids: [t1.id, t2.id] }
    assert_redirected_to sl1_dashboard_path

    t1.reload
    assert_equal t1.assigned_to_id, @user.id
    assert_equal t1.status, SearchTicket::STATUS_SEARCH_IN_PROGRESS
    t2.reload
    assert_equal t2.assigned_to_id, @user.id
    assert_equal t2.status, SearchTicket::STATUS_SEARCH_IN_PROGRESS
  end


  should "NOT ALLOW assignement or Status change for any other ticket status" do
    t1 = create(:search_ticket, status: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2)
    t2 = create(:search_ticket, status: SearchTicket::STATUS_REVIEW_BY_COORDINATOR)

    patch sl1_start_search_path, params: { search_ticket_ids: [t1.id, t2.id] }
    assert_redirected_to sl1_dashboard_path

    t1.reload
    assert t1.assigned_to_id != @user.id
    assert t1.status != SearchTicket::STATUS_SEARCH_IN_PROGRESS

    t2.reload
    assert t2.assigned_to_id != @user.id
    assert t2.status != SearchTicket::STATUS_SEARCH_IN_PROGRESS
  end





  # ## Should that Check incoming items are of status new
  # ## Should assign tickets to current user
  # ## Should update status to Search_In_Progress
  #
  # should "not allow starting search on tickets in a differnt location" do
  #
  #   ### FOR NOW THIS NEEDS TO BE LEFT AS IS
  #   status = SearchTicket::STATUS_SEARCH_IN_PROGRESS
  #   other_tickets = create_list(:search_ticket, 2, status: status)
  #   proper_tickets = create_list(:search_ticket, 2, status: status, location: @user.location)
  #
  #   # assert_raise ActiveRecord::RecordNotFound do
  #   #   #put sl1_start_search_path, params: { search_ticket_ids: ["1","2"] }
  #   # end
  # end
  #
  # should "check incoming items are status new" do
  #   # new_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_NEW)
  #
  #   in_progress_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
  #
  #   in_progress_tickets.each do |ipt|
  #     assert_not_equal SearchTicket::STATUS_NEW, ipt.status do
  #       assert_redirected_to sl1_new_tickets_path
  #     end
  #   end
  #
  #
  # end
  #
  # should "update and assign user to tickets" do
  #   new_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_NEW)
  #   search_ticket_ids_local = [];
  #
  #   new_tickets.each do |nt|
  #     assert_equal SearchTicket::STATUS_NEW, nt.status, "Precondition: Status must be = STATUS_NEW"
  #     search_ticket_ids_local.push(nt.id.to_s)
  #     # puts nt.status
  #   end
  #
  #   # puts "\nSEARCH TICKET IDS\n"
  #   # puts search_ticket_ids_local.inspect
  #
  #   # put :update, sl1_start_searches_path([search_ticket_ids: search_ticket_ids_local])
  #   # put sl1_start_searches_path, params: {search_ticket_ids: ["1","2"]}
  #
  #   # new_tickets.first.id, params: { search_ticket_ids: ["1"]}
  #
  #   # assert_redirected_to sl1_assigned_to_me_tickets_path
  #
  #   # new_tickets.each do |nt2|
  #   #   assert_equal SearchTicket::STATUS_SEARCH_IN_PROGRESS, nt2.status, "PostCondition: Status must change to = STATUS_SEARCH_IN_PROGRESS"
  #   # end
  #
  # end

end
