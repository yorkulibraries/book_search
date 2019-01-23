class Sl1::DashboardController < Sl1::AuthorizedBaseController
  def show
    @new_tickets = current_user.location.tickets.new_tickets.recently_updated_first
    @assigned_tickets = current_user.assigned_tickets.in_progress_tickets.recently_updated_first
  end
end
