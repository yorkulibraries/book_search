class Coordinator::DashboardController < Coordinator::AuthorizedBaseController
  def show
    @under_review_tickets = SearchTicket.under_review_tickets  
  end
end
