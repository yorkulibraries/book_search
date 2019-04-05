class Sl2::ChangeRequestorController < Sl2::AuthorizedBaseController

  def edit
    @patron = Patron.new
    @ticket = SearchTicket.find(params[:id])
  end

  def update
    @ticket = SearchTicket.find(params[:id])

    @patron = Patron.find_by_login_id(patron_params[:login_id])

    if @patron && @ticket.status != SearchTicket::STATUS_RESOLVED

      old_patron = Patron.find(@ticket.patron_id)
      @ticket.update_attribute(:patron_id, @patron.id)

      # create a work log
      @work_log = SearchTicket::WorkLog.new()
      @work_log.work_type = SearchTicket::WorkLog::WORK_TYPE_NOTE
      @work_log.employee = current_user
      @work_log.search_ticket = @ticket
      @work_log.result = SearchTicket::WorkLog::RESULT_PATRON_CHANGED
      @work_log.note = "Changed patron from #{old_patron.name} to #{@patron.name}"
      @work_log.save

    else
      # for now show an error and ask to for Patron to login first
      @error_message = "We could not find patron with that Login ID. To create a new patron, you should login to the patron portal first."
    end
  end


  def patron_params
    params.require(:patron).permit(:login_id)
  end
end
