class SearchRequest::SearchedArea < ApplicationRecord
  # attributes: :search_area_id :search_attempt_id :search_request_id

  ## VALIDATIONS
  validates_presence_of :search_area_id, :search_attempt_id, :search_request_id

  ## RELATIONS
  belongs_to :search_request
  belongs_to :search_area
  belongs_to :search_attempt, foreign_key: "search_attempt_id", class_name: "SearchRequest::SearchAttempt"

  ## SCOPES

end
