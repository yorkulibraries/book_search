class Sl2::DashboardController < Sl2::AuthorizedBaseController
  def show
    @escalated_tickets = SearchTicket.escalated_tickets.recently_updated_first
    @assigned_tickets = SearchTicket.in_progress_tickets.where(assigned_to_id: current_user.id).recently_updated_first
  end
end
