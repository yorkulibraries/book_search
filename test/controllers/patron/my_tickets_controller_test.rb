require 'test_helper'

class Patron::MyTicketsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @patron = create(:patron)
    @my_ticket = create(:search_ticket, patron_id: @patron.id)
    log_user_in(@patron)
  end

  should "load index page" do
    get patron_my_tickets_url
    assert_response :success

    assert_select "h3", "Active Tickets"  ## Too Specific. Re-think this one?
  end

  should "load show page" do
    get patron_my_ticket_url (@my_ticket.id)
    assert_response :success

    assert_select "h3", @my_ticket.item_title
  end


end
