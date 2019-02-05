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
      assert_equal SearchTicket::STATUS_NEW, t.status
      assert_redirected_to find_this_item_request_help_url(ticket_id: t.id)
    end
  end

  should "Ensure that ILS_location is properly matched up to Location Model" do
    get find_this_item_legal_url, params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  "test" }
    post find_this_item_request_help_url

    ticket = SearchTicket.last
    assert_equal ticket.location.ils_code, @temp_ticket.item_location
  end

  # should "Ensure it uses the first Location found if no ILS_location is provided or doesn't match" do
  #   @item_data["item_location"] = "SOMETHING that DOES NOT MATCH"
  #   get find_this_item_legal_url, params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  "test" }
  #   post find_this_item_request_help_url
  #
  #   ticket = SearchTicket.last
  #   assert_equal ticket.location.ils_code, Location.first.ils_code
  # end
  should "NEW/UNKNOWN LOCATION: Set ticket.location to default location" do

    ## RESET TEST DATA
    Location.all.each do |loc|
      loc.default_location = false
      loc.save
    end

    ## SET TO HAVE ATLEAST ONE DEFAULT LOCATION
    dl = Location.first
    dl.default_location = true
    dl.save

    # puts "Default Location: #{dl.name} | #{dl.ils_code} | #{dl.default_location}"

    @item_data["item_location"] = "SOMETHING that DOES NOT MATCH"
    get find_this_item_legal_url,
      params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  "test" }

    get find_this_item_request_help_url, params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  "test" }

    ticket = SearchTicket.last

    # post find_this_item_request_help_url
    # ticket = SearchTicket.last
    #puts "SEARCH TICKET #{ticket.inspect}"

    new_location = Location.where(ils_code: ticket.location.ils_code, default_location: true).first
    assert_equal ticket.location.ils_code, new_location.ils_code
    assert_equal new_location.default_location, true

  end
  should "NEW/UNKNOWN LOCATION: Create new location if no default location" do
    @locations = Location.all
    @locations.each do |loc|
      loc.default_location = false
      loc.save
    end
    # puts "Starting Location Count: #{Location.all.count}"

    @item_data["item_location"] = "SOMETHING that DOES NOT MATCH"

    get find_this_item_legal_url,
      params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  "test" }

    get find_this_item_request_help_url,
      params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  "test" }

    ## Check if Location was added
    # puts "Location Count After: #{Location.all.count}"
    # puts  Location.all.inspect

    assert_equal @item_data["item_location"], Location.where(ils_code: @item_data["item_location"]).first.ils_code

    ticket = SearchTicket.last
    # puts "SEARCH TICKET #{ticket.inspect}"

    new_location = @locations.where(ils_code: ticket.location.ils_code).first
    assert_equal ticket.location.ils_code, new_location.ils_code

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
