require 'test_helper'

class Coordinator::ChangeRequestorControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:employee, role: Employee::ROLE_COORDINATOR)
    log_user_in(@user)
  end


  should "show edit form" do
    ticket = create(:search_ticket)
    get edit_coordinator_change_requestor_path(ticket), xhr: true
    assert_response :success
  end


  should "change requestor if one is found" do
    p = create(:patron)
    ticket = create(:search_ticket)

    assert ticket.patron_id != p.id
    patch coordinator_change_requestor_path(ticket), xhr: true, params: { patron: {login_id: p.login_id } }

    ticket.reload
    assert ticket.patron_id == p.id
  end

  should "not change requestor if one is not found" do
    ticket = create(:search_ticket)

    p_id = ticket.patron_id
    patch coordinator_change_requestor_path(ticket), xhr: true, params: { patron: {login_id: "234234" } }

    ticket.reload
    assert ticket.patron_id == p_id
  end

  should "not change requestor if ticket status is STATUS_RESOLVED" do
    p = create(:patron)

    ticket = create(:search_ticket)
    ticket.update_attribute(:status, SearchTicket::STATUS_RESOLVED)


    assert ticket.patron_id != p.id

    patch coordinator_change_requestor_path(ticket), xhr: true, params: { patron: { login_id: p.login_id } }

    ticket.reload
    assert ticket.patron_id != p.id
  end
end
