class Sl1::AuthorizedBaseController < AuthenticatedEmployeeController
  ## All SL1 Processes will exetend from this controller
  ## This controller's job is to ensure only SL2 Employees can access SL2 Processes

  before_action :sl1_employee_required

  private
  def sl1_employee_required
    if current_user.role != Employee::ROLE_LEVEL_ONE
      redirect_to root_url, notice: "You are not authorized to use this part of the website"
    end
  end

end
