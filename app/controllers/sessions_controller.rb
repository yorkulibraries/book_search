class SessionsController < ApplicationController
  CAS_LOGIN_ID = "HTTP_PYORK_CYIN"
  CAS_FIRST_NAME = "HTTP_PYORK_FIRST_NAME"
  CAS_LAST_NAME = "HTTP_PYORK_LAST_NAME"
  CAS_EMAIL = "HTTP_PYORK_EMAIL"
  CAS_USER_TYPE = "HTTP_PYORK_TYPE"

  def new

    if Rails.env.development?
      uid = development_mode_login_id
    else
      uid = request.headers[CAS_LOGIN_ID]
    end

    # IMPROTANT: check if Employee is logging in first
    user = Employee.find_by_login_id(uid)
    # IMPORTANT: check if Patron si logging in second
    user = Patron.find_by_login_id(uid) if user == nil

    if user
      session[:user_id] = user.id
      session[:login_id] = user.login_id
      session[:user_type] = user.class.name

      ## Redirect to root, which will decide where to redirect to later
      redirect_to root_url
    else

      # If user doesn't exist, lest make a record for him.
      email = request.headers[CAS_EMAIL]
      login_id = request.headers[CAS_LOGIN_ID]
      name = "#{request.headers[CAS_FIRST_NAME]} #{request.headers[CAS_LAST_NAME]}"

      patron = Patron.build_new_user(login_id, email, name)
      patron.save(validate: false)

      # Redirecting to Patron dashboard here, since it's a brand new user
      redirect_to patron_my_tickets_path, notice: "Welcome to BookSearch app!"
    end

  end

  def destroy

  end


  ### PRIVATE METHODS
  private

  # for development only,
  def development_mode_login_id
    params[:as] || Employee.first.login_id
  end

end
