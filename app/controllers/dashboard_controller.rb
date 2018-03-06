class DashboardController < ApplicationController
  def index
    @current_status = params[:status] || SearchRequest::STATUS_OPEN


    @reports = SearchRequest.where(status: @current_status)


  end

end
