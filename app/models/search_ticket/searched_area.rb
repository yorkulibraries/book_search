class SearchTicket::SearchedArea < ApplicationRecord
  # attributes: :search_area_id :work_log_id :search_ticket_id

  ## VALIDATIONS
  validates_presence_of :search_area_id, :search_ticket_id

  ## RELATIONS
  belongs_to :search_ticket
  belongs_to :search_area
  belongs_to :work_log, foreign_key: "work_log_id", class_name: "SearchTicket::WorkLog", required: false

  ## SCOPES

end
