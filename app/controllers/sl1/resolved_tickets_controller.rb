class Sl1::ResolvedTicketsController < Sl1::AuthorizedBaseController
  def index
    @tickets = SearchTicket.resolved_tickets
    @resolved_tickets = SearchTicket.resolved_tickets
  end
end
