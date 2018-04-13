class Sl1::NewRequestsController < ApplicationController
  def index
    # @requests = SearchRequest.new_requests
    @requests = SearchRequest.all    
  end
end
