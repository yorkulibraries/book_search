class Coordinator::AuthorizedBaseController < AuthenticatedEmployeeController
  ## All Coordinator Processes will exetend from this controller
  ## This controller's job is to ensure only Coordinator/Manager Employees can access Coordinator Processes

  before_action :coordinator_employee_required

  private
  def coordinator_employee_required
    if current_user.role != Employee::ROLE_COORDINATOR && current_user.role != Employee::ROLE_MANAGER
      redirect_to root_url, notice: "You are not authorized to use this part of the website"
    end
  end
end
