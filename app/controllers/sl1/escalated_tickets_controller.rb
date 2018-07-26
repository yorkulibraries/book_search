class Sl1::EscalatedTicketsController < Sl1::AuthorizedBaseController
  def index
    @tickets = SearchTicket.escalated_tickets
  end
end
