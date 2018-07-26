class Sl1::NewTicketsController < Sl1::AuthorizedBaseController

  def index
    @tickets = SearchTicket.new_tickets
    @new_tickets = SearchTicket.new_tickets
  end



end
