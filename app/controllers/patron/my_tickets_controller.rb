class Patron::MyTicketsController < AuthenticatedPatronController

  def index
    @tickets = SearchTicket.where(patron: current_patron).unresolved_tickets
    @resolved_tickets =  SearchTicket.where(patron: current_patron).resolved_tickets
  end

  def show
    @ticket = @my_ticket = SearchTicket.find(params[:id])
  end

  private

  # def search_ticket_params
  #   params.require(:search_ticket).permit(
  #     :item_id, :item_callnumber, :item_title, :item_author,
  #     :item_volume, :item_issue, :item_year,:location_id, :status,
  #     patron_attributes: [:name, :email, :login_id]
  #   )
  # end

end
