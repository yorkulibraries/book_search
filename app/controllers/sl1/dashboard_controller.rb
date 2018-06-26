class Sl1::DashboardController < AuthenticatedEmployeeController
  def show
    @new_tickets = SearchTicket.new_tickets
  end
end
