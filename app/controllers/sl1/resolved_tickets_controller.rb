class Sl1::ResolvedTicketsController < AuthenticatedEmployeeController
  def index
    @tickets = SearchTicket.resolved_tickets
  end
end
