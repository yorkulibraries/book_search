class Sl2::SearchTicketController < AuthenticatedEmployeeController

  before_action :load_search_ticket

  def show
  end

  private

  def load_search_ticket
    @ticket = SearchTicket.find(params[:id])
  end
end
