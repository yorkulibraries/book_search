require 'test_helper'


class ExternalIntegrationFlowTest < ActionDispatch::IntegrationTest

  setup do
    @referer_url = "http://foo.com"
    @ticket = create(:search_ticket)
    @user = create(:patron)
    @item_data = @ticket.attributes.slice("item_location","item_title", "item_callnumber", "item_author", "item_id", "item_volume", "item_issue", "item_year")
  end


  should "go through the whole process" do
    get find_this_item_legal_url, params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  @referer_url }
    assert_response :success

    assert_select "h5", @ticket.item_title
    assert_select "dd#item_callnumber", @ticket.item_callnumber
    assert_select "dd#item_author", @ticket.item_author

    assert_select "#help_find_item_button", "Help me find this item"

    assert_no_difference ("SearchTicket.count") do
      get find_this_item_request_help_url
      assert_response :redirect
      assert_redirected_to login_url
    end

    # must login first
    log_user_in(@user)

    assert_difference ("SearchTicket.count") do
      get find_this_item_request_help_url
      assert_response :success
    end

  end

end
