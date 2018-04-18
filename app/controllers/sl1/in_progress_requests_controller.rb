class Sl1::InProgressRequestsController < ApplicationController

  def index
    @requests = SearchRequest.in_progress_requests
  end

end
