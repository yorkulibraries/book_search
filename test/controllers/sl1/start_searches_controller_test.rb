require 'test_helper'

class Sl1::StartSearchesController < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end
  
  ## Should that Check incoming items are of status new
  ## Should assign tickets to current user
  ## Should update status to Search_In_Progress
  
  should "check incoming items are status new" do
    # new_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_NEW)    
    
    in_progress_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
    
    in_progress_tickets.each do |ipt|
      assert_not_equal SearchTicket::STATUS_NEW, ipt.status do 
        assert_redirected_to sl1_new_tickets_path
      end
    end
    
    
  end

  should "update and assign user to tickets" do
    new_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_NEW)
    search_ticket_ids_local = [];

    new_tickets.each do |nt|
      assert_equal SearchTicket::STATUS_NEW, nt.status, "Precondition: Status must be = STATUS_NEW"
      search_ticket_ids_local.push(nt.id.to_s)
      puts nt.status
    end
    
    puts "\nSEARCH TICKET IDS\n"
    puts search_ticket_ids_local.inspect

    # put :update, sl1_start_searches_path([search_ticket_ids: search_ticket_ids_local])
    # put sl1_start_searches_path, params: {search_ticket_ids: ["1","2"]}
    
    # new_tickets.first.id, params: { search_ticket_ids: ["1"]}

    # assert_redirected_to sl1_my_search_tickets_path
    
    # new_tickets.each do |nt2|
    #   assert_equal SearchTicket::STATUS_SEARCH_IN_PROGRESS, nt2.status, "PostCondition: Status must change to = STATUS_SEARCH_IN_PROGRESS"
    # end
    
  end

end
