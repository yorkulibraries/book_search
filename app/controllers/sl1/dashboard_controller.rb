class Sl1::DashboardController < ApplicationController
  def show
    @new_tickets = SearchTicket.new_tickets
  end
end
