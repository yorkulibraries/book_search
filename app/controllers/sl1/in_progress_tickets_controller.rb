class Sl1::InProgressTicketsController < Sl1::AuthorizedBaseController

  def index
    @tickets = SearchTicket.in_progress_tickets
    @in_progress_tickets = SearchTicket.in_progress_tickets
  end

end
