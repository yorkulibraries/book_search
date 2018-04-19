class DashboardController < ApplicationController
  def index
    @current_status = params[:status] || SearchTicket::STATUS_NEW


    @tickets = SearchTicket.where(status: @current_status)


  end

end
