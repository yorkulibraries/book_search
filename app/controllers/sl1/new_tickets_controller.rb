class Sl1::NewTicketsController < ApplicationController

  def index
    @tickets = SearchTicket.new_tickets
  end

  

end
