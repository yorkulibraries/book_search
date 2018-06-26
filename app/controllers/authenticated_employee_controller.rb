class AuthenticatedEmployeeController < ApplicationController

  def current_user
    @current_user = Employee.find(session[:session_id])
  end
  helper_method :current_user

end
