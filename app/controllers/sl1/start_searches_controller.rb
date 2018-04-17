class Sl1::StartSearchesController < ApplicationController
  def update

    # Assign the new requests to employee
    # update status of search_request(s) to SearchRequest::STATUS_SEARCH_IN_PROGRESS
    # Take user to My Search Requests but for now return to SL1 Index.
    
    if params[:search_request_ids]
      
      params[:search_request_ids].each do |sreq|
        request = SearchRequest.where(id: sreq).update(assigned_to: Employee.first, status: " #{SearchRequest::STATUS_SEARCH_IN_PROGRESS}")
        
        # TODO:
        # What if the request is not new, rather different status? Then what?
        # Send notification on error 
        
      end
      
      redirect_to sl1_my_search_requests_url, notice: "successfully assigned requests"
    else
      redirect_to sl1_new_requests_url, error: "Could not assign requests."
    end    

  end
  
  private

    # Never trust parameters from the scary internet, only allow the white list through.
    # def search_request_params
    #   params.require(:search_requests).permit(:assigned_to_id, :status)
    # end
  
end
