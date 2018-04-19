class SearchTicket::WorkLog < ApplicationRecord
  # attributes:  :search_ticket_id :employee_id :result :found_location :note, :work_type

  ## CALLBACKS
  before_create :set_resolution_before_create

  ## CONSTANTS
  WORK_TYPE_SEARCH = "work_type_search"

  RESULT_UNKNOWN = "unknown"
  RESULT_FOUND = "found"
  RESULT_NOT_FOUND = "not_found"

  ## VALIDATIONS
  validates_presence_of :employee_id, :search_ticket_id

  ## RELATIONS
  belongs_to :employee
  belongs_to :search_ticket

  has_many :searched_areas
  has_many :search_areas, through: :searched_area

  ## SCOPES

  ## METHODS


  private

  def set_resolution_before_create
    resolution = RESULT_UNKNOWN
  end


end
