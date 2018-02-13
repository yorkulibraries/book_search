class MissingItemsReportController < ApplicationController
  def index
    @reports = MissingItemReport.where(status: MissingItemReport::STATUS_OPEN).order('resolution desc')
  end
end
