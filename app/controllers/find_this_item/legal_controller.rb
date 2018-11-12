class FindThisItem::LegalController < ApplicationController

  layout "external_integration"

  SESSION_REFERER_ID = "find_this_item_referer"
  SESSION_ITEM_DATA = "find_this_item_data"

  # path to this should be /find_this_item/test_cases
  def index
    # this is a page with temporary book lists for testing
    @tickets = []
    3.times do |i|
      ticket = SearchTicket.new
      ticket.item_title = Faker::Book.unique.title
      ticket.item_callnumber = "CD #{Faker::Code.unique.asin}"
      ticket.item_author = Faker::Book.unique.author
      ticket.item_id = rand(2900020030020..2900020040020)
      ticket.item_volume = "Vol 1"
      ticket.item_issue = "Issue 2"
      ticket.item_year = rand(1998..2017)
      ticket.item_location = Location.all.pluck(:ils_code).sample
      @tickets<< ticket
    end
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
