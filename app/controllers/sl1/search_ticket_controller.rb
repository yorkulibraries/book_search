class Sl1::SearchTicketController < ApplicationController

  before_action :load_search_ticket
  before_action :check_ticket_status, only: [:edit, :update]

  def show
  end

  def edit
    @search_attempt = SearchTicket::SearchAttempt.new    
  end

  def update

    sa = @ticket.search_attempts.build
    sa.employee = current_user
    sa.search_ticket = @ticket
    sa.save(validate: false)

    redirect_to sl1_search_ticket_path(@ticket), notice: "Search Attempt recorded"
  end


  private

  def load_search_ticket
    @ticket = SearchTicket.find(params[:id])
  end

  def check_ticket_status
    if @ticket.status != SearchTicket::STATUS_SEARCH_IN_PROGRESS || @ticket.search_attempts.size > 0
      redirect_to sl1_search_ticket_path(@ticket), notice: "Search in progress already."
    end
  end
end
