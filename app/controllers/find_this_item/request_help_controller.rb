class FindThisItem::RequestHelpController < AuthenticatedPatronController
  layout "external_integration"

  def create
    item = JSON.parse(session[FindThisItem::LegalController::SESSION_ITEM_DATA])

    ticket = SearchTicket.new(item)
    ticket.patron = current_user

    # Ensure Location is properly matched. If not matched use the first location in the list
    # Later, we might add default import location attribute to the Location model.
    l = Location.find_by_ils_code(ticket.item_location.strip)
    if l == nil
      l = Location.first
    end
    ticket.location = l
    ticket.status = SearchTicket::STATUS_NEW
    
    if ticket.save
      redirect_to find_this_item_request_help_url(ticket_id: ticket.id)
    else
      puts ticket.errors.messages
      redirect_to find_this_item_legal_url
    end

  end

  def show
    @ticket = current_user.search_tickets.find(params[:ticket_id])
    @referer_url = session[FindThisItem::LegalController::SESSION_REFERER_ID]
    session[:temp_ticket_id] = nil
  end
end
