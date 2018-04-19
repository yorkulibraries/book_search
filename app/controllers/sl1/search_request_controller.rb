class Sl1::SearchRequestController < ApplicationController

  before_action :load_search_request
  before_action :check_request_status, only: [:edit, :update]

  def show
  end

  def edit
    @search_attempt = SearchRequest::SearchAttempt.new    
  end

  def update

    sa = @request.search_attempts.build
    sa.employee = current_user
    sa.search_request = @request
    sa.save(validate: false)

    redirect_to sl1_search_request_path(@request), notice: "Search Attempt recorded"
  end


  private

  def load_search_request
    @request = SearchRequest.find(params[:id])
  end

  def check_request_status
    if @request.status != SearchRequest::STATUS_SEARCH_IN_PROGRESS || @request.search_attempts.size > 0
      redirect_to sl1_search_request_path(@request), notice: "Search in progress already."
    end
  end
end
