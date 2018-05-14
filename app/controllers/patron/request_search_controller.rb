class Patron::RequestSearchController < ApplicationController
  def index
    # this is going to be a list of books with buttons to test ticket generation
  end

	
  def show

  end

  def new
    @ticket = SearchTicket.new(search_ticket_params)
    @patron = Patron.new(patron_params)
    @location = Location.find_by_ils_code(params[:location])
    @ticket.location = @location
    @ticket.patron = @patron
  end

  def create

    @ticket = SearchTicket.new(search_ticket_params)
    @patron = @ticket.patron
    @location = @ticket.location

    # TODO: rework this to make it more smooth, with Patron and SearchTicket creation
    # check if patron exists, if not make a new one
    @patron.save
    @ticket.patron = @patron

    if @ticket.save
      redirect_to patron_request_search_path(@ticket), notice: "Created search Request"
    else
      render action: :new
    end

  end

  private
  def search_ticket_params
    params.require(:search_ticket).permit(:item_id, :item_callnumber, :item_title, :item_author,
                                          :item_volume, :item_issue, :item_year,:location_id,
                                        patron_attributes: [:name, :email, :login_id]
                                      )
  end

  def patron_params
    params.require(:patron).permit(:name, :email, :login_id)
  end


end
