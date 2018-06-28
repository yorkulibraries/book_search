class Sl1::InProgressTicketsController < AuthenticatedEmployeeController

  def index
    @tickets = SearchTicket.in_progress_tickets
  end

end
