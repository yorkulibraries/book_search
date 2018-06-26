class DashboardController < ApplicationController
  def index

    ## TODO: Check the user type and redirect to the appropriate dashboard

    #redirect_to sl1_dashboard_path
    render text: "In Progress"
  end

end
