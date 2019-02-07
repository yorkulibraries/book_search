class Sl2::StartSearchesController < Sl2::AuthorizedBaseController


  def update

    # Assign the new tickets to employee
    # update status of search_ticket(s) to SearchTicket::STATUS_SEARCH_IN_PROGRESS
    # Take user to My Search Tickets

    if params[:search_ticket_ids]

      ticket_ids = params[:search_ticket_ids]

      if(ticket_ids.is_a?(Array))
        ## MULTIPLE TICKET IDS IS SELECTED
        ## Loop all items to ensure all are escalated tickets, otherwise redirect to New Tickets
        ticket_ids.each do |sreq|
          @ticket = SearchTicket.find(sreq)
          check_ticket_status(@ticket, SearchTicket::STATUS_ESCALATED_TO_LEVEL_2)
        end

        # Update items to be assigned to current user and update status to in progress
        ticket_ids.each do |sreq|
          @ticket = SearchTicket.find(sreq)
          @ticket.update(assigned_to: current_user, status: "#{SearchTicket::STATUS_SEARCH_IN_PROGRESS}")
        end
      else
        ## "TICKET IDS IS SOLO"
        @ticket = SearchTicket.find(ticket_ids)
        check_ticket_status(@ticket, SearchTicket::STATUS_ESCALATED_TO_LEVEL_2)
        @ticket.update(assigned_to: current_user, status: "#{SearchTicket::STATUS_SEARCH_IN_PROGRESS}")

      end ## is_a?(Array) close

      redirect_to sl2_search_ticket_path(@ticket), notice: "Successfully assigned tickets"

    else
      # redirect_to sl1_new_tickets_url, error: "Could not assign tickets due to Error."
      redirect_to sl2_dashboard_path, error: "Could not assign tickets due to Error."
    end

    return
  end

  private

  def check_ticket_status(ticket_check, status_type)
    if ticket_check.status != status_type
      ticket_check.errors.add(ticket_check.item_title, message: "Item #{ticket_check.item_title} Status is not '#{status_type}'")
      redirect_to sl2_dashboard_path, error: "Could not assign tickets."
    end
  end


    # Never trust parameters from the scary internet, only allow the white list through.
    # def search_ticket_params
    #   params.require(:search_tickets).permit(:assigned_to_id, :status)
    # end

end
