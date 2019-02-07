class AuthenticatedPatronController < ApplicationController

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
    # Looking up users by login_id, because that is unique.
    @current_user = Patron.find_by_login_id(session[:login_id])    
  end
  helper_method :current_user

  def current_patron
    @current_patron = @current_user
  end
  helper_method :current_patron

end
