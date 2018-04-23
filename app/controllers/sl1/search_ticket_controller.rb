class Sl1::SearchTicketController < ApplicationController

  before_action :load_search_ticket
  before_action :check_ticket_status, only: [:edit, :update]

  def show
  end

  def edit
    @work_log = SearchTicket::WorkLog.new
  end

  def update

    @work_log = @ticket.work_logs.build(work_log_params)
    @work_log.work_type = SearchTicket::WorkLog::WORK_TYPE_SEARCH
    @work_log.employee = current_user
    @work_log.search_ticket = @ticket

    # add search_ticket id to searched_areas
    @work_log.searched_areas.each do |sa|
      sa.search_ticket = @ticket
    end

    if @work_log.save
      redirect_to sl1_search_ticket_path(@ticket), notice: "Work Log recorded"
    else
      render action: :edit
    end
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
     params.require(:work_log).permit(:result, :found_location, :note, search_area_ids: [])
  end
end
