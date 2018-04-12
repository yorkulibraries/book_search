class DashboardController < ApplicationController
  def index
    @current_status = params[:status] || SearchRequest::STATUS_NEW


    @requests = SearchRequest.where(status: @current_status)


  end

end
