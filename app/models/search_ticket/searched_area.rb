class SearchTicket::SearchedArea < ApplicationRecord
  # attributes: :search_area_id :search_attempt_id :search_ticket_id

  ## VALIDATIONS
  validates_presence_of :search_area_id, :search_attempt_id, :search_ticket_id

  ## RELATIONS
  belongs_to :search_ticket
  belongs_to :search_area
  belongs_to :search_attempt, foreign_key: "search_attempt_id", class_name: "SearchTicket::SearchAttempt"

  ## SCOPES

end
