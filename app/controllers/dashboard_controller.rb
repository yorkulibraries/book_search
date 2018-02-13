class DashboardController < ApplicationController
  def index
    @reports = MissingItemReport.all
  end

end
