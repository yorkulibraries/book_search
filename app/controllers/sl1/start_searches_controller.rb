class Sl1::StartSearchesController < ApplicationController

  before_action :current_user
  
  def update

    # Assign the new tickets to employee
    # update status of search_ticket(s) to SearchTicket::STATUS_SEARCH_IN_PROGRESS
    # Take user to My Search Tickets
    
    if params[:search_ticket_ids]
      
      # Loop all items to ensure all are new tickets, otherwise redirect to New Tickets
      params[:search_ticket_ids].each do |sreq|
        @ticket = SearchTicket.find(sreq)
        check_ticket_status(@ticket)
      end
      
      # Update items to be assigned to current user and update status to in progress
      params[:search_ticket_ids].each do |sreq|          
        @ticket.update(assigned_to: @current_user, status: " #{SearchTicket::STATUS_SEARCH_IN_PROGRESS}")          
      end
      
      redirect_to sl1_my_search_tickets_url, notice: "successfully assigned tickets"
    else
      redirect_to sl1_new_tickets_url, error: "Could not assign tickets."
    end    

  end
  
  private
  
  def check_ticket_status(ticket_check)
    if ticket_check.status != SearchTicket::STATUS_NEW
      ticket_check.errors.add(ticket_check.item_title, message: "Item Status is not 'NEW'")
      redirect_to sl1_new_tickets_url, error: "Could not assign tickets."
    end
  end
  

    # Never trust parameters from the scary internet, only allow the white list through.
    # def search_ticket_params
    #   params.require(:search_tickets).permit(:assigned_to_id, :status)
    # end    
  
end
