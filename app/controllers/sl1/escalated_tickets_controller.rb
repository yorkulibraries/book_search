class Sl1::EscalatedTicketsController < AuthenticatedEmployeeController
  def index
    @tickets = SearchTicket.escalated_tickets
  end
end
