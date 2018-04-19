class Sl1::StartSearchesController < ApplicationController
  def update

    # Assign the new tickets to employee
    # update status of search_ticket(s) to SearchTicket::STATUS_SEARCH_IN_PROGRESS
    # Take user to My Search Tickets but for now return to SL1 Index.
    
    if params[:search_ticket_ids]
      
      params[:search_ticket_ids].each do |sreq|
        ticket = SearchTicket.where(id: sreq).update(assigned_to: Employee.first, status: " #{SearchTicket::STATUS_SEARCH_IN_PROGRESS}")
        
        # TODO:
        # What if the ticket is not new, rather different status? Then what?
        # Send notification on error 
        
      end
      
      redirect_to sl1_my_search_tickets_url, notice: "successfully assigned tickets"
    else
      redirect_to sl1_new_tickets_url, error: "Could not assign tickets."
    end    

  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    # def search_ticket_params
    #   params.require(:search_tickets).permit(:assigned_to_id, :status)
    # end
  
end
