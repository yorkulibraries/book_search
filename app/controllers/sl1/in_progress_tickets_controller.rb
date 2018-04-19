class Sl1::InProgressTicketsController < ApplicationController

  def index
    @tickets = SearchTicket.in_progress_tickets
  end

end
