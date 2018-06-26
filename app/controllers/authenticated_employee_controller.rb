class AuthenticatedEmployeeController < ApplicationController

  before_action :login_required
  def logged_in?
    current_user
  end

  def login_required
    unless logged_in?
      session[:redirect_to_url] = request.fullpath unless request.fullpath == login_path
      redirect_to login_url, alert: "You must login before accessing this page"
    end
  end


  def current_user
    @current_user = Employee.find(session[:user_id])
  end
  helper_method :current_user

end
