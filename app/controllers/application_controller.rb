class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user = Employee.first
  end
  helper_method :current_user


  def current_patron
    @current_patron = Patron.first
  end
  helper_method :current_patron

end
