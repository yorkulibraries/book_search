class Sl1::MySearchRequestsController < ApplicationController

  def index
    @requests = SearchRequest.where(assigned_to_id: @current_user.id)
  end

  private


    # Never trust parameters from the scary internet, only allow the white list through.
    # def search_request_params
    #   params.require(:search_requests).permit(:assigned_to_id, :status)
    # end

end
