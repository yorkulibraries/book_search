class DashboardController < ApplicationController
  def index

    ## TODO: Check the user type and redirect to the appropriate dashboard

    redirect_to sl1_dashboard_path

    # @current_status = params[:status] || SearchTicket::STATUS_NEW
    #
    #
    # @tickets = SearchTicket.where(status: @current_status)


  end

end
