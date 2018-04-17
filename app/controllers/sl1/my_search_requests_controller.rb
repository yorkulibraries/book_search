class Sl1::MySearchRequestsController < ApplicationController

  before_action :get_current_user
  
  def index
    @requests = SearchRequest.where(assigned_to_id: @current_user.id)
  end
  
  private
  
    def get_current_user
      @current_user = Employee.first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def search_request_params
    #   params.require(:search_requests).permit(:assigned_to_id, :status)
    # end
  
end
