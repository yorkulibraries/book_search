class Sl1::NewTicketsController < AuthenticatedEmployeeController

  def index
    @tickets = SearchTicket.new_tickets
  end



end
