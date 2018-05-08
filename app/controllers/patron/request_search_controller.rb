class Patron::RequestSearchController < ApplicationController
  def index
    # this is going to be a list of books with buttons to test ticket generation
  end


  def show

  end

  def new
    @search_ticket = SearchTicket.new(search_ticket_params)
    @patron = Patron.new(patron_params)
    @location = Location.find_by_ils_code(params[:location])
  end

  def create

  end

  private
  def search_ticket_params
    params.require(:search_ticket).permit(:item_id, :item_callnumber, :item_title, :item_author,
                                          :item_volume, :item_issue, :item_year, :item_location )
  end

  def patron_params
    params.require(:patron).permit(:name, :email, :login_id)
  end
end
