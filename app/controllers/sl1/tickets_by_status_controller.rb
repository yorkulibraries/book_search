class Sl1::TicketsByStatusController < Sl1::AuthorizedBaseController

  def index
    @status = params[:status]

    case @status
    when SearchTicket::STATUS_NEW
      @tickets = SearchTicket.new_tickets.recently_updated_first
    when SearchTicket::STATUS_ESCALATED_TO_LEVEL_2
      @tickets = SearchTicket.escalated_tickets.recently_updated_first
    when SearchTicket::STATUS_RESOLVED
      @tickets = SearchTicket.resolved_tickets.recently_updated_first
    else
      @status = "unknown"
      @tickets = []
    end

  end
end
