class SearchController < AuthenticatedEmployeeController

  def index
    @search_query = q = params[:q]

    @tickets = SearchTicket.where(id: q).or(SearchTicket.where(item_id: q))
  end

  def show

    # this is a mini redirector to the proper place based on the level
    case current_user.role
    when Employee::ROLE_LEVEL_ONE
      url = sl1_search_ticket_url(params[:id])
    when Employee::ROLE_LEVEL_TWO
      url = sl2_search_ticket_url(params[:id])
    when Employee::ROLE_COORDINATOR
      url = coordinator_search_ticket_url(params[:id])
    when Employee::ROLE_MANAGER
      url = coordinator_search_ticket_url(params[:id])
    else
      url = dashboard_url
    end

    redirect_to url
  end
end
