class FindThisItem::LegalController < ApplicationController

  layout "external_integration"

  SESSION_REFERER_ID = "find_this_item_referer"
  SESSION_ITEM_DATA = "find_this_item_data"

  # path to this should be /find_this_item/test_cases
  def index
    # this is a page with temporary book lists for testing
  end


  def show
    # record referrer
    session[SESSION_REFERER_ID] = request.env["HTTP_REFERER"]

    # save book item details into session
    session[SESSION_ITEM_DATA] = params[:item]

    if params[:item]
      @item = ActiveSupport::HashWithIndifferentAccess.new(JSON.parse params[:item])
    else
      ticket = SearchTicket.new
      ticket.item_title = "Test"
      @item = ticket.attributes
    end

  end



end
