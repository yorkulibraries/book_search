class Manager::EmployeesController < Manager::AuthorizedBaseController
  def show
    @employee = Employee.find(params[:id])

    @assigned_count = @employee.assigned_tickets.count
    @resolved_count = @employee.work_logs.resolved_found.count
    @under_review_count = @employee.work_logs.under_review.count
    @in_acquisitions_count = @employee.work_logs.in_acquisitions.count
  end
end
