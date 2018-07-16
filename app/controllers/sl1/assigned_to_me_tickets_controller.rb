class Sl1::AssignedToMeTicketsController < AuthenticatedEmployeeController

  def index
    @tickets = SearchTicket.where(assigned_to_id: current_user.id)
    @assigned_tickets = SearchTicket.where(assigned_to_id: current_user.id)
  end

  private


  # Never trust parameters from the scary internet, only allow the white list through.
  # def search_ticket_params
  #   params.require(:search_tickets).permit(:assigned_to_id, :status)
  # end

end
