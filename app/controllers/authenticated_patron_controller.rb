class AuthenticatedPatronController < ApplicationController

  def current_user
    @current_user = Patron.find(session[:session_id])
  end
  helper_method :current_user



  def current_patron
    @current_patron = Patron.first
  end
  helper_method :current_patron

end
