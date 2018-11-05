require 'test_helper'

class Patron::MyTicketsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @patron = create(:patron)
    log_user_in(@patron)
  end

  should "load index page" do
    resolved_tickets = create_list(:search_ticket, 3, patron: @patron, status: SearchTicket::STATUS_RESOLVED)
    new_tickets = create_list(:search_ticket, 2, patron: @patron, status: SearchTicket::STATUS_NEW)

    get patron_my_tickets_url
    assert_response :success

    assert_select "[data-ticket-status=#{SearchTicket::STATUS_NEW}]", { count: new_tickets.size}
    assert_select "[data-ticket-status]", { count: new_tickets.size + resolved_tickets.size }

  end

  should "load show page" do
    ticket = create(:search_ticket)
    get patron_my_ticket_url (ticket.id)
    assert_response :success

    assert_select "h3", ticket.item_title
  end


end
