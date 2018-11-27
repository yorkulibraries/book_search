class SessionsController < ApplicationController
  CAS_LOGIN_ID = "HTTP_PYORK_CYIN"
  CAS_FIRST_NAME = "HTTP_PYORK_FIRST_NAME"
  CAS_LAST_NAME = "HTTP_PYORK_LAST_NAME"
  CAS_EMAIL = "HTTP_PYORK_EMAIL"
  CAS_USER_TYPE = "HTTP_PYORK_TYPE"

  def new

    if Rails.env.development?
      login_id = development_mode_login_id
    else
      login_id = request.headers[CAS_LOGIN_ID]
    end

    # IMPROTANT: check if Employee is logging in first
    user = Employee.find_by_login_id(login_id)
    # IMPORTANT: check if Patron is logging in second
    user = Patron.find_by_login_id(login_id) if user == nil

    if user
      session[:user_id] = user.id
      session[:login_id] = user.login_id
      session[:user_type] = user.class.name      
      ## Redirect to root, which will decide where to redirect to later
      redirect_to root_url, notice: "Welcome back #{user.name}!"
    else
      # If user doesn't exist, lest make a record for him.
      email = request.headers[CAS_EMAIL]
      login_id = request.headers[CAS_LOGIN_ID]
      name = "#{request.headers[CAS_FIRST_NAME]} #{request.headers[CAS_LAST_NAME]}"

      patron = Patron.build_new_user(login_id, email, name)

      if patron.save
        redirect_to root_url, notice: "Welcome to BookSearch App!"
      else
        redirect_to invalid_login_url, notice: "There was an issue logging in"
      end

    end

  end

  def destroy

  end


  ### PRIVATE METHODS
  private

  # for development only,
  def development_mode_login_id
    case params[:as]
    when Employee::ROLE_MANAGER
      Employee.where(role: Employee::ROLE_MANAGER).first.login_id
    when Employee::ROLE_COORDINATOR
      Employee.where(role: Employee::ROLE_COORDINATOR).first.login_id
    when Employee::ROLE_LEVEL_ONE
      Employee.where(role: Employee::ROLE_LEVEL_ONE).first.login_id
    when Employee::ROLE_LEVEL_TWO
      Employee.where(role: Employee::ROLE_LEVEL_TWO).first.login_id
    when "patron"
      Patron.first.login_id
    else
      Patron.first.login_id
    end
  end

end
