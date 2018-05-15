class Patron::RequestSearchController < ApplicationController
  def index
    # this is going to be a list of books with buttons to test ticket generation
  end


  def show
    @ticket = SearchTicket.find(params[:id])
  end

  def new
    # TODO this needs to be extracted from authentication system, if the params aren't present
    p = Patron.new(patron_params)

    @patron = Patron.find_by_login_id(p.login_id)
    if @patron == nil
      @patron = p
      @patron.save
    end

    @ticket = SearchTicket.new(search_ticket_params)
    @location = Location.find_by_ils_code(params[:location])
    @ticket.location = @location
    @ticket.patron = @patron
  end

  def create

    @ticket = SearchTicket.new(search_ticket_params)
    @location = @ticket.location
    @patron = @ticket.patron

    if @ticket.save
      redirect_to patron_request_search_path(@ticket), notice: "Created search Request"
    else
      render action: :new
    end

  end

  private
  def search_ticket_params
    params.require(:search_ticket).permit(:item_id, :item_callnumber, :item_title, :item_author,
                                          :item_volume, :item_issue, :item_year,:location_id, :patron_id,
                                        patron_attributes: [:id, :name, :email]
                                      )
  end

  def patron_params
    params.require(:patron).permit(:name, :email, :login_id)
  end


end
