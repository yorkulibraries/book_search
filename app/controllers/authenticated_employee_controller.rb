class AuthenticatedEmployeeController < ApplicationController

  before_action :login_required

  def logged_in_as_employee?
    current_user
  end

  def login_required

    if session[:user_type] != Employee.new.class.name
      session[:redirect_to_url] = nil
      redirect_to patron_my_tickets_path, alert: "You are not allowed to access this section of the app."
    elsif  !logged_in_as_employee?
      session[:redirect_to_url] = request.fullpath unless request.fullpath == login_path
      redirect_to login_url, alert: "You must login before accessing this page"
    end

  end


  def current_user
    # Looking up users by login_id, because that is unique.
    # One Patron ID could be the same as Employee ID
    # So that creates bit of confusion, Employee ID 1 and Patron ID 1
    @current_user = Employee.find_by_login_id(session[:login_id])
  end
  helper_method :current_user

end
