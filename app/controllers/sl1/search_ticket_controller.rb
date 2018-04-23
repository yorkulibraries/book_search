class Sl1::SearchTicketController < ApplicationController

  before_action :load_search_ticket
  before_action :check_ticket_status, only: [:edit, :update]

  def show
  end

  def edit
    @work_log = SearchTicket::WorkLog.new
  end

  def update

    wl = @ticket.work_logs.build(work_log_params)
    wl.work_type = SearchTicket::WorkLog::WORK_TYPE_SEARCH
    #sa.employee = current_user
    wl.search_ticket = @ticket
    wl.save(validate: false)

    redirect_to sl1_search_ticket_path(@ticket), notice: "Work Log recorded"
  end


  private

  def load_search_ticket
    @ticket = SearchTicket.find(params[:id])
  end

  def check_ticket_status
    if @ticket.status != SearchTicket::STATUS_SEARCH_IN_PROGRESS || @ticket.work_logs.size > 0
      redirect_to sl1_search_ticket_path(@ticket), notice: "Search in progress already."
    end
  end

  def work_log_params
     params.require(:work_log).permit(:result, :found_location, :note, searched_area_attributes: [:search_area_id])
  end
end
