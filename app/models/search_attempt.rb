class SearchAttempt < ApplicationRecord
  # attributes:  :missing_item_report_id :employee_id :resolution :found_location :note

  ## CALLBACKS
  before_create :set_resolution_before_create

  ## CONSTANTS
  FOUND_IN_LOCATION = "in_location"
  FOUND_NEAR_LOCATION = "near_location"
  FOUND_IN_SORTING_AREA = "in_sorting_area"
  FOUND_ON_SORTING_CART = "on_sorting_cart"
  FOUND_IN_BOOK_RETURN_AREA = "in_book_return_area"

  RESOLUTION_UNKNOWN = "unknown"
  RESOLUTION_FOUND = "found"
  RESOLUTION_NOT_FOUND = "not_found"

  ## VALIDATIONS
  validates_presence_of :employee_id, :missing_item_report_id

  ## RELATIONS
  belongs_to :employee
  belongs_to :missing_item_report

  ## SCOPES

  ## METHODS


  private

  def set_resolution_before_create
    resolution = RESOLUTION_UNKNOWN
  end


end
