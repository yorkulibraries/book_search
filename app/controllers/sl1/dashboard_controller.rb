class Sl1::DashboardController < Sl1::AuthorizedBaseController
  def show
    @new_tickets = SearchTicket.new_tickets.recently_updated_first
    @assigned_tickets = SearchTicket.in_progress_tickets.where(assigned_to_id: current_user.id).recently_updated_first
  end
end
