class Sl2::DashboardController < ApplicationController
  def show
    @tickets = SearchTicket.escalated_tickets
  end
end
