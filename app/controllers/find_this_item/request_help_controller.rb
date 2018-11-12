class FindThisItem::RequestHelpController < AuthenticatedPatronController

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

    if ticket.save
      redirect_to find_this_item_request_help_url
    else
      puts ticket.errors.messages
      redirect_to find_this_item_legal_url
    end

  end

  def show
  end
end
