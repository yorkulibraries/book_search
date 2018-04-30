class Patron::RequestSearchController < ApplicationController
  def index
    # this is going to be a list of books with buttons to test ticket generation
  end

  def show
    @search_ticket = SearchTicket.new(search_ticket_params)
    @patron = current_patron
  end

  private
  def search_ticket_params
    params.require(:search_ticket).permit(:item_id, :item_callnumber, :item_title, :item_author,
                                          :item_volume, :item_issue, :item_year, :item_location )
  end
end
