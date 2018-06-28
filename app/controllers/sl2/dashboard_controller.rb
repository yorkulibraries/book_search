class Sl2::DashboardController < AuthenticatedEmployeeController
  def show
    @tickets = SearchTicket.escalated_tickets
  end
end
