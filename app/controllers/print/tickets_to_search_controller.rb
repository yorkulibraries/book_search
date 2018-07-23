class Print::TicketsToSearchController < AuthenticatedEmployeeController
  
  layout 'print'
  def index
    if params[:ticket_ids]
      # puts params[:ticket_ids].inspect
      @tickets = SearchTicket.find(params[:ticket_ids])      
    else
      @tickets = {}
      @search_areas = {}
    end
  end
end
