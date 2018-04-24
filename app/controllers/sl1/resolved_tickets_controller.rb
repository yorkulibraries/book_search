class Sl1::ResolvedTicketsController < ApplicationController
  def index
    @tickets = SearchTicket.resolved_tickets
  end
end
