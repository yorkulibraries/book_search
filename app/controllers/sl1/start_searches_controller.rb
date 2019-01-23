class Sl1::StartSearchesController < Sl1::AuthorizedBaseController


  def update

    # Assign the new tickets to employee
    # update status of search_ticket(s) to SearchTicket::STATUS_SEARCH_IN_PROGRESS
    # Take user to My Search Tickets

    if params[:search_ticket_ids]

      ticket_ids = params[:search_ticket_ids]

      if(ticket_ids.is_a?(Array))
        # Loop all items to ensure all are new tickets, otherwise redirect to New Tickets
        ticket_ids.each do |sreq|
          @ticket = find_ticket(sreq)
          check_ticket_status(@ticket)
        end

        # Update items to be assigned to current user and update status to in progress
        ticket_ids.each do |sreq|
          @ticket = find_ticket(sreq)
          @ticket.update(assigned_to: current_user, status: "#{SearchTicket::STATUS_SEARCH_IN_PROGRESS}")
        end
      else
        puts "TICKET IDS IS SOLO!!!"
        @ticket = find_ticket(ticket_ids)
        check_ticket_status(@ticket)
        @ticket.update(assigned_to: current_user, status: "#{SearchTicket::STATUS_SEARCH_IN_PROGRESS}")

      end ## is_a?(Array) close

      # redirect_to sl1_my_search_tickets_url, notice: "successfully assigned tickets"
      redirect_to sl1_dashboard_url, notice: "Successfully assigned tickets"
    else
      redirect_to sl1_dashboard_url, error: "Could not assign tickets due to Error."
    end

    return

  end

  private

  def check_ticket_status(ticket_check)
    if ticket_check.status != SearchTicket::STATUS_NEW
      ticket_check.errors.add(ticket_check.item_title, message: "Item Status is not 'NEW'")
      redirect_to sl1_dashboard_url, error: "Could not assign tickets."
    end
  end

  def find_ticket(id)
    return SearchTicket.find(id)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def search_ticket_params
    #   params.require(:search_tickets).permit(:assigned_to_id, :status)
    # end

end
