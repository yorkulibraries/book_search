class Sl1::StartSearchesController < ApplicationController
  def update
    # @requests = SearchRequest.new_requests
    
    # Assign the new requests to employee
    # update status of search_request(s) to SearchRequest::STATUS_SEARCH_IN_PROGRESS
    # Take user to My Search Requests but for now return to SL1 Index.
    
    if params[:search_request_ids]
      # puts "::::::::INSPECTION::::::::"
      # puts params[:search_request_ids].inspect
      
      params[:search_request_ids].each do |sreq|
        request = SearchRequest.where(id: sreq).update(assigned_to: Employee.find(21), status: " #{SearchRequest::STATUS_SEARCH_IN_PROGRESS}")
        # puts request.inspect
      end
    end

    # SearchRequest.update_all({assigned_to_id: 1, status: SearchRequest::STATUS_SEARCH_IN_PROGRESS}, {id: params[:search_request_ids]})
    
    redirect_to sl1_new_requests_url
  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    # def search_request_params
    #   params.require(:search_requests).permit(:assigned_to_id, :status)
    # end
  
end
