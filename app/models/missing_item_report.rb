class MissingItemReport < ApplicationRecord
  # attributes:  :item_id :item_callnumber :item_title :patron_id :location_id  :resolution :status  :note

  ## CONSTANTS
  STATUS_OPEN = "open"
  STATUS_CLOSED = "closed"
  STATUS_CANCELEED = "cancelled"

  RESOLUTION_UNKNOWN = "unknown"
  RESOLUTION_FOUND = "found"
  RESOLUTION_NOT_FOUND = "not_found"

  ## VALIDATIONS
  validates_uniqueness_of :item_id
  validates_presence_of :item_id, :patron_id

  ## RELATIONS
  # belongs_to :patron

  ## SCOPES

  ## METHODS

end
