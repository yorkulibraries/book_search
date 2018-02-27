class DashboardController < ApplicationController
  def index
    @current_status = params[:status] || MissingItemReport::STATUS_OPEN


    @reports = MissingItemReport.where(status: @current_status)


  end

end
