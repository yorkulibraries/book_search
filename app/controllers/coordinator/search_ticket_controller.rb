class Coordinator::SearchTicketController < Coordinator::AuthorizedBaseController
  before_action :load_search_ticket

  def show
  end

  private

  def load_search_ticket
    @ticket = SearchTicket.find(params[:id])
  end

end
