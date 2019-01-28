class Coordinator::TicketsByStatusController < Coordinator::AuthorizedBaseController

  def index
    @status = params[:status]

    case @status
    when SearchTicket::STATUS_NEW
      @tickets = current_user.location.tickets.new_tickets.recently_updated_first.page params[:page]
    when SearchTicket::STATUS_SEARCH_IN_PROGRESS
      @tickets = current_user.location.tickets.in_progress_tickets.recently_updated_first.page params[:page]
    when SearchTicket::STATUS_ESCALATED_TO_LEVEL_2
      @tickets = current_user.location.tickets.escalated_tickets.recently_updated_first.page params[:page]
    when SearchTicket::STATUS_REVIEW_BY_COORDINATOR
      @tickets = current_user.location.tickets.under_review_tickets.recently_updated_first.page params[:page]
    when SearchTicket::STATUS_RESOLVED
      @tickets = current_user.location.tickets.resolved_tickets.recently_updated_first.page params[:page]
    else
      @status = "unknown"
      @tickets = []
    end

  end

end
