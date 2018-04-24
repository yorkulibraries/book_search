class Sl1::EscalatedTicketsController < ApplicationController
  def index
    @tickets = SearchTicket.escalated_tickets
  end
end
