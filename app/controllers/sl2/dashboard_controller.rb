class Sl2::DashboardController < AuthenticatedEmployeeController
  def show
    @escalated_tickets = SearchTicket.escalated_tickets
    @assigned_tickets = SearchTicket.where(assigned_to_id: current_user.id)
  end
end
