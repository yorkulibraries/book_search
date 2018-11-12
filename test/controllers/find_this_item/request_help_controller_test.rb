require 'test_helper'

class FindThisItem::RequestHelpControllerTest < ActionDispatch::IntegrationTest

  setup do
    @patron = create(:patron)
    log_user_in(@patron)
    @temp_ticket = build(:search_ticket)
    @item_data = @temp_ticket.attributes.slice("item_location","item_title", "item_callnumber", "item_author", "item_id", "item_volume", "item_issue", "item_year")


  end


  should "Create a Search Ticket for data in the session" do

    assert_difference "SearchTicket.count", 1 do
      get find_this_item_legal_url, params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  "test" }
      post find_this_item_request_help_url
      t = SearchTicket.last
      assert_redirected_to find_this_item_request_help_url(ticket_id: t.id)
    end
  end

  should "Ensure that ILS_location is properly matched up to Location Model" do
    get find_this_item_legal_url, params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  "test" }
    post find_this_item_request_help_url

    ticket = SearchTicket.last
    assert_equal ticket.location.ils_code, @temp_ticket.item_location
  end

  should "Ensure it uses the first Location found if no ILS_location is provided or doesn't match" do
    @item_data["item_location"] = "SOMETHING that DOES NOT MATCH"
    get find_this_item_legal_url, params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  "test" }
    post find_this_item_request_help_url

    ticket = SearchTicket.last
    assert_equal ticket.location.ils_code, Location.first.ils_code
  end


  should "show details after creating the ticket" do
    get find_this_item_legal_url, params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  "test" }
    post find_this_item_request_help_url

    t = SearchTicket.last

    get find_this_item_request_help_url(ticket_id: t.id)
    assert_response :success

    assert_select "[data-ticket-id]", { value: t.id }
  end

  should "only show details for user's tickets not any others" do
    other_ticket = create(:search_ticket)
    patrons_ticket = create(:search_ticket, patron: @patron)

    get find_this_item_request_help_url(ticket_id: patrons_ticket.id)
    assert_response :success


    assert_raises ActiveRecord::RecordNotFound do
      get find_this_item_request_help_url(ticket_id: other_ticket)
    end

  end

end
