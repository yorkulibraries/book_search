class SearchTicket::WorkLog < ApplicationRecord
    # attributes:  :search_ticket_id :employee_id :result :found_location :note, :work_type

  ## CALLBACKS
  before_create :set_resolution_before_create

  ## CONSTANTS
  WORK_TYPE_SEARCH = "work_type_search"
  WORK_TYPE_REVIEW = "work_type_review"

  RESULT_UNKNOWN = "unknown"
  RESULT_FOUND = "found"
  RESULT_NOT_FOUND = "not_found"
  RESULT_ANOTHER_SEARCH_REQUESTED = "another_search_requested"
  RESULT_SENT_TO_ACQUISITIONS = "sent_to_acquisitions"

  RESULTS = [RESULT_UNKNOWN, RESULT_FOUND, RESULT_NOT_FOUND]

  ## VALIDATIONS
  validates_presence_of :employee_id, :search_ticket_id, :work_type, :result
  validates_presence_of :found_location, if: Proc.new { |log| log.result == RESULT_FOUND }
  #validate :validate_searched_areas
  validates :searched_areas, length: { minimum: 1, message: " must be selected (at least one)" }

  ## RELATIONS
  belongs_to :employee
  belongs_to :search_ticket

  has_many :searched_areas
  has_many :search_areas, through: :searched_areas


  ## SCOPES

  ## METHODS


  private

  def set_resolution_before_create
    resolution = RESULT_UNKNOWN
  end

  ## CUSTOM VALIDATION METHODS
  def validate_searched_areas
    errors.add(:searched_areas, "Please selected which areas you've searched") if searched_areas.size < 1
  end


end
