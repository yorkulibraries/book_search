class Sl1::SearchTicketController < Sl1::AuthorizedBaseController

  before_action :load_search_ticket
  before_action :check_ticket_status, only: [:edit, :update]

  def show
    @work_log = SearchTicket::WorkLog.new
  end

  def edit
    @work_log = SearchTicket::WorkLog.new
    render action: :show
  end

  def update

    @work_log = SearchTicket::WorkLog.new(work_log_params)
    @work_log.work_type = SearchTicket::WorkLog::WORK_TYPE_SEARCH
    @work_log.employee = current_user
    @work_log.search_ticket = @ticket

    # add search_ticket id to searched_areas
    @work_log.searched_areas.each do |sa|
      sa.search_ticket = @ticket
    end

    if @work_log.save

      if @work_log.result == SearchTicket::WorkLog::RESULT_FOUND
        @ticket.status = SearchTicket::STATUS_RESOLVED
        @ticket.resolution = SearchTicket::RESOLUTION_FOUND
        @ticket.save

      elsif @work_log.result == SearchTicket::WorkLog::RESULT_NOT_FOUND
        @ticket.status = SearchTicket::STATUS_ESCALATED_TO_LEVEL_2
        @ticket.assigned_to_id = nil
        @ticket.save
      end


      redirect_to sl1_search_ticket_path(@ticket), notice: "Work Log recorded"
    else
      render action: 'show'
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
     params.require(:search_ticket_work_log).permit(:result, :found_location, :note, search_area_ids: [])
  end
end
