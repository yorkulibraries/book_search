class Coordinator::SearchTicketController < Coordinator::AuthorizedBaseController
  before_action :load_search_ticket

  def show
  end

  def update
    @work_log = @ticket.work_logs.new
    @work_log.work_type = SearchTicket::WorkLog::WORK_TYPE_REVIEW
    @work_log.employee = current_user
    @work_log.search_ticket = @ticket

    puts

    if params[:acquisitions].present?
      @ticket.status = SearchTicket::STATUS_RESOLVED
      @ticket.assigned_to = nil
      @ticket.resolution = SearchTicket::RESOLUTION_IN_ACQUISITIONS

      ## add WorkLog result here
      @work_log.result = SearchTicket::WorkLog::RESULT_SENT_TO_ACQUISITIONS
      @work_log.note = "Coordinator sent this SearchTicket to Acquisitions department"

      ## maybe send an email here
    elsif params[:search_again].present?
      puts "HSOULD BE HERE"
      @ticket.status = SearchTicket::STATUS_ESCALATED_TO_LEVEL_2
      @ticket.assigned_to = nil

      ## add WorkLog result here
      @work_log.result = SearchTicket::WorkLog::RESULT_ANOTHER_SEARCH_REQUESTED
      @work_log.note = "Coordinator requested another search for this SearchTicket"
    end

    @ticket.save(validate: false)
    @work_log.save(validate: false)

    redirect_to coordinator_search_ticket_path(@ticket)
  end

  private

  def load_search_ticket
    @ticket = SearchTicket.find(params[:id])
  end

end
