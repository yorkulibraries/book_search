class MissingItemReport < ApplicationRecord
  # attributes:  :item_id :item_callnumber :item_title :patron_id :location_id  :resolution :status  :note

  ## CALLBACKS
  before_create :set_status_and_resolution_before_create

  ## CONSTANTS
  STATUS_OPEN = "open"
  STATUS_CLOSED = "closed"
  STATUS_CANCELLED = "cancelled"

  RESOLUTION_UNKNOWN = "unknown"
  RESOLUTION_FOUND = "found"
  RESOLUTION_NOT_FOUND = "not_found"

  RESOLUTIONS = [RESOLUTION_UNKNOWN, RESOLUTION_FOUND, RESOLUTION_NOT_FOUND]
  STATUSES = [STATUS_OPEN, STATUS_CLOSED, STATUS_CANCELLED]

  ## VALIDATIONS
  validates_uniqueness_of :item_id
  validates_presence_of :item_id, :patron_id

  ## RELATIONS
  belongs_to :patron
  has_many :search_attempts

  ## SCOPES

  ## METHODS


  private

  def set_status_and_resolution_before_create
    status = STATUS_OPEN
    resolution = RESOLUTION_UNKNOWN
  end


end
