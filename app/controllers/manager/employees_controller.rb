class Manager::EmployeesController < Manager::AuthorizedBaseController
  def show
    @employee = Employee.find(params[:id])
  end
end
