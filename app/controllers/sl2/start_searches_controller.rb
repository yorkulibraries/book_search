class Sl2::StartSearchesController < Sl2::AuthorizedBaseController

  def update
    ids = params[:search_ticket_ids]

    if ids.kind_of?(Array)
      ids.each do |id|
        ticket = SearchTicket.find(id)

        if allowed_ticket_status?(ticket)
          ticket.update(assigned_to: current_user, status: SearchTicket::STATUS_SEARCH_IN_PROGRESS)
        end

      end

      redirect_to sl2_dashboard_path, notice: "Assigned multiple search tickets to you!"
    else
      ticket = SearchTicket.find(ids)

      if allowed_ticket_status?(ticket)
        ticket.update(assigned_to: current_user, status: "#{SearchTicket::STATUS_SEARCH_IN_PROGRESS}")
      end

      redirect_to sl2_search_ticket_path(ticket)
    end

  end


  # def update
  #
  #   # Assign the new tickets to employee
  #   # update status of search_ticket(s) to SearchTicket::STATUS_SEARCH_IN_PROGRESS
  #   # Take user to My Search Tickets
  #
  #   if params[:search_ticket_ids]
  #
  #     ticket_ids = params[:search_ticket_ids]
  #
  #     if(ticket_ids.is_a?(Array))
  #       ## MULTIPLE TICKET IDS IS SELECTED
  #       ## Loop all items to ensure all are escalated tickets, otherwise redirect to New Tickets
  #       ticket_ids.each do |sreq|
  #         @ticket = SearchTicket.find(sreq)
  #         check_ticket_status(@ticket)
  #       end
  #
  #       # Update items to be assigned to current user and update status to in progress
  #       ticket_ids.each do |sreq|
  #         @ticket = SearchTicket.find(sreq)
  #         @ticket.update(assigned_to: current_user, status: "#{SearchTicket::STATUS_SEARCH_IN_PROGRESS}")
  #       end
  #     else
  #       ## "TICKET IDS IS SOLO"
  #       @ticket = SearchTicket.find(ticket_ids)
  #       check_ticket_status(@ticket)
  #       @ticket.update(assigned_to: current_user, status: "#{SearchTicket::STATUS_SEARCH_IN_PROGRESS}")
  #
  #     end ## is_a?(Array) close
  #
  #     redirect_to sl2_search_ticket_path(@ticket), notice: "Successfully assigned tickets"
  #
  #   else
  #     # redirect_to sl1_new_tickets_url, error: "Could not assign tickets due to Error."
  #     redirect_to sl2_dashboard_path, error: "Could not assign tickets due to Error."
  #   end
  #
  # end

  private

  def allowed_ticket_status?(ticket)
    allowed_statuses = [SearchTicket::STATUS_NEW, SearchTicket::STATUS_ESCALATED_TO_LEVEL_2]


    if !allowed_statuses.include?(ticket.status)
      return false
    else
      return true
    end
  end


end
