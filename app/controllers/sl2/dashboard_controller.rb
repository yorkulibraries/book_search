class Sl2::DashboardController < Sl2::AuthorizedBaseController
  def show
    @escalated_tickets = current_user.location.tickets.escalated_tickets.recently_updated_first
    @assigned_tickets = current_user.assigned_tickets.in_progress_tickets.where(assigned_to_id: current_user.id).recently_updated_first
  end
end
