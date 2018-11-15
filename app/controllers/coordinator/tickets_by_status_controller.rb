class Coordinator::TicketsByStatusController < Coordinator::AuthorizedBaseController

  def index
    @status = params[:status]

    case @status
    when SearchTicket::STATUS_NEW
      @tickets = SearchTicket.new_tickets
    when SearchTicket::STATUS_SEARCH_IN_PROGRESS
      @tickets = SearchTicket.in_progress_tickets
    when SearchTicket::STATUS_ESCALATED_TO_LEVEL_2
      @tickets = SearchTicket.escalated_tickets
    when SearchTicket::STATUS_REVIEW_BY_COORDINATOR
      @tickets = SearchTicket.under_review_tickets
    when SearchTicket::STATUS_RESOLVED
      @tickets = SearchTicket.resolved_tickets
    else
      @status = "unknown"
      @tickets = []
    end

  end

end
