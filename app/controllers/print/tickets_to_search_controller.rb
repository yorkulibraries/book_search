class Print::TicketsToSearchController < ApplicationController
  # before_action :current_user
  layout 'print'
  def index
    if params[:ticket_ids]
      puts params[:ticket_ids].inspect
      # @tickets = SearchTicket.where("id in (?)", params[:ticket_ids].join(',').to_i)
      @tickets = SearchTicket.find(params[:ticket_ids])
      # @search_areas_sl1 = SearchArea.where(is_primary: true)
      # @search_areas = SearchArea.all
    else
      @tickets = {}
      # @search_areas_sl1 = {}
      # @search_areas_sl2 = {}
      @search_areas = {}
    end
  end
end
