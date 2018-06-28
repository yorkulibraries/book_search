class Sl1::DashboardController < AuthenticatedEmployeeController
  def show
    @new_tickets = SearchTicket.new_tickets
    @assigned_tickets = SearchTicket.where(assigned_to_id: current_user.id)    
  end
end
