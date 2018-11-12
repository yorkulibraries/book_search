require 'test_helper'

class FindThisItem::LegalControllerTest < ActionDispatch::IntegrationTest

  setup do
    @referer_url = "http://foo.com"
    @ticket = create(:search_ticket)

    @item_data = @ticket.attributes.slice("item_location","item_title", "item_callnumber", "item_author", "item_id", "item_volume", "item_issue", "item_year")
  end

  should "doesn't need to be authenticated" do
    # get root_path, params: { id: 12 }, headers: { "HTTP_REFERER" => "http://foo.com" }
    get find_this_item_legal_url, params: { item: @item_data.to_json }, headers: { "HTTP_REFERER" =>  @referer_url }
    assert_response :success


    # check referer
    assert_equal session[FindThisItem::LegalController::SESSION_REFERER_ID], @referer_url

    # check session
    assert_equal session[FindThisItem::LegalController::SESSION_ITEM_DATA], @item_data.to_json

    # check data is being displayed

  end
end
