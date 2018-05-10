class Patron::MyTicketsController < ApplicationController

  def index
    @my_tickets = SearchTicket.where(patron: current_patron)
  end

  def show
    @my_ticket = SearchTicket.find(params[:id])
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
