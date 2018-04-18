class SearchRequest < ApplicationRecord
  # attributes:  :item_id :item_callnumber :item_title :patron_id :location_id  :resolution :status  :note

  ## CALLBACKS
  before_create :set_status_and_resolution_before_create

  ## CONSTANTS
  STATUS_NEW = "new"
  STATUS_SEARCH_IN_PROGRESS = "search_in_progress"
  STATUS_ESCALATED_TO_LEVEL_2 = "escalated_to_level_2"
  STATUS_RESOLVED = "resolved"


  RESOLUTION_UNKNOWN = "unknown"
  RESOLUTION_FOUND = "found"
  RESOLUTION_NOT_FOUND = "not_found"
  RESOLUTION_CANCELLED = "cancelled"
  RESOLUTION_DUPLICATE = "duplicate"

  RESOLUTIONS = [RESOLUTION_UNKNOWN, RESOLUTION_FOUND, RESOLUTION_NOT_FOUND, RESOLUTION_CANCELLED, RESOLUTION_DUPLICATE]
  STATUSES = [STATUS_NEW, STATUS_SEARCH_IN_PROGRESS, STATUS_ESCALATED_TO_LEVEL_2, STATUS_RESOLVED]

  ## VALIDATIONS
  validates_presence_of :item_id, :patron_id

  ## RELATIONS
  belongs_to :patron
  belongs_to :assigned_to, required: false, foreign_key: "assigned_to_id", class_name: "Employee"
  has_many :search_attempts

  ## SCOPES
  scope :new_requests, -> { where(status: STATUS_NEW) }
  scope :in_progress_requests, -> { where(status: STATUS_SEARCH_IN_PROGRESS) }

  ## METHODS
  def assigned_to_name
    if assigned_to == nil
      "Nobody"
    else
      assigned_to.name
    end
  end

  private

  def set_status_and_resolution_before_create
    status = STATUS_NEW
    resolution = RESOLUTION_UNKNOWN
  end


end
