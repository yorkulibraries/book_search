require 'test_helper'

class Sl1::EscalatedTicketsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @user = create(:employee, role: Employee::ROLE_LEVEL_ONE)
    log_user_in(@user)
  end

  should "show escalated search tickets" do
    escalated_tickets = create_list(:search_ticket, 2, status: SearchTicket::STATUS_ESCALATED_TO_LEVEL_2, assigned_to: @user)
    other_tickets = create_list(:search_ticket, 3, status: SearchTicket::STATUS_NEW, assigned_to: @user)

    get sl1_escalated_tickets_path
    assert_response :success

    assert_select "[data-escalated-tickets-count]", { value: escalated_tickets.size }
  end



end
