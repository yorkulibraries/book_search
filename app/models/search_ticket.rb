class SearchTicket < ApplicationRecord
  # attributes:  :item_id :item_callnumber :item_title :item_author :item_volume :item_issue :item_year :item_location  :patron_id :location_id  :resolution :status  :note

  ## CALLBACKS
  before_create :set_status_and_resolution_before_create

  ## CONSTANTS
  STATUS_NEW = "new"
  STATUS_SEARCH_IN_PROGRESS = "search_in_progress"
  STATUS_ESCALATED_TO_LEVEL_2 = "escalated_to_level_2"
  STATUS_REVIEW_BY_COORDINATOR = "review_by_coordinator"
  STATUS_RESOLVED = "resolved"


  RESOLUTION_UNKNOWN = "unknown"
  RESOLUTION_FOUND = "found"
  RESOLUTION_NOT_FOUND = "not_found"
  RESOLUTION_CANCELLED = "cancelled"
  RESOLUTION_DUPLICATE = "duplicate"
  RESOLUTION_IN_ACQUISITIONS = "in_acquisitions"
  RESOLUTION_REPURCHAISING = "repurchasing"
  RESOLUTION_DECLARED_MISSING = "declared_missing"

  RESOLUTIONS = [RESOLUTION_UNKNOWN, RESOLUTION_FOUND, RESOLUTION_NOT_FOUND, RESOLUTION_CANCELLED, RESOLUTION_DUPLICATE]
  STATUSES = [STATUS_NEW, STATUS_SEARCH_IN_PROGRESS, STATUS_ESCALATED_TO_LEVEL_2, STATUS_RESOLVED, STATUS_REVIEW_BY_COORDINATOR]

  ## VALIDATIONS
  validates_presence_of :item_id, :patron_id

  ## RELATIONS
  belongs_to :patron
  belongs_to :assigned_to, required: false, foreign_key: "assigned_to_id", class_name: "Employee"
  belongs_to :location

  has_many :work_logs

  accepts_nested_attributes_for :patron


  ## SCOPES
  scope :new_tickets, -> { where(status: STATUS_NEW) }
  scope :in_progress_tickets, -> { where(status: STATUS_SEARCH_IN_PROGRESS) }
  scope :escalated_tickets, -> { where(status: STATUS_ESCALATED_TO_LEVEL_2) }
  scope :resolved_tickets, -> { where(status: STATUS_RESOLVED) }
  scope :unresolved_tickets, -> { where.not(status: STATUS_RESOLVED) }
  scope :under_review_tickets, -> { where(status: STATUS_REVIEW_BY_COORDINATOR) }

  scope :created_past_7_days, -> { where("created_at > ?", Time.now-7.days) }
  scope :updated_past_7_days, -> { where("updated_at > ?", Time.now-7.days) }

  scope :recently_updated_first, -> { order(updated_at: :desc) }

  paginates_per 6
  
  ## METHODS
  def assigned_to_name
    if assigned_to == nil
      "Nobody"
    else
      assigned_to.name
    end
  end

  def patron_name
    if patron == nil
      "THIS SHOULDN'T HAPPEN"
    else
      patron.name
    end
  end

  def location_name
    if location == nil
      "THIS SHOULDN'T HAPPEN"
    else
      location.name
    end
  end

  def last_updated
    if work_logs.size > 0
      return work_logs.first.created_at
    else
      return created_at
    end
  end

  def last_searched_by
    if work_logs.size == 0
      return "No one"
    else
      return work_logs.last.employee_name
    end
  end

  def print_barcode(height: 50, width: 1)
    require 'barby'
    require 'barby/barcode/code_128'
    require 'barby/outputter/png_outputter'

    barcode = Barby::Code128A.new(item_id)
    outputter = Barby::PngOutputter.new(barcode)
    outputter.height = height
    outputter.xdim = width
    blob = outputter.to_png #Raw PNG data
    return ['data:image/png;base64,', blob].pack('A*m').gsub(/\n/, '')
  end


  def ticket_status_description
    case status
    when STATUS_NEW
      return  "Just In: #{patron_name} has submitted this ticket."
    when STATUS_SEARCH_IN_PROGRESS
      return "Search In Progress: #{assigned_to_name} is searching for this Item."
    when STATUS_ESCALATED_TO_LEVEL_2
      return "Escalated: #{assigned_to_name} looked for this item and couldn't find it."
    when STATUS_REVIEW_BY_COORDINATOR
      return "Under Review: After #{work_logs.size} Searches Item is still missing"
    when STATUS_RESOLVED
      return ticket_resolution_description
    else
      return "Something has gone wrong. This ticket doesn't have a status attached."
    end
  end

  def ticket_resolution_description
    case resolution
    when SearchTicket::RESOLUTION_FOUND
      return "Found: We've located this item and it has been placed on hold for the patron."
    when SearchTicket::RESOLUTION_NOT_FOUND
      return "Not Found: We could not find this item at this time."
    when SearchTicket::RESOLUTION_CANCELLED
      return "Cancelled: We've cancelled this ticket."
    when SearchTicket::RESOLUTION_DUPLICATE
      return "Duplicate: This ticket is a duplicate of another one."
    when SearchTicket::RESOLUTION_IN_ACQUISITIONS
      return "In Acquisitions: Some one from the acquisitions department is reviewing this ticket."
    when SearchTicket::RESOLUTION_REPURCHAISING
      return "Repurchasing: We have decided to repurchase this item."
    when SearchTicket::RESOLUTION_DECLARED_MISSING
      return "Declared Missing: This item has been declared missing and will not be re-circulated"
    else
      return "#{resolution.humanize}: The status of this ticket is unknown at the moment."
    end
  end

  def patron_ticket_status_description
    case status
    when STATUS_NEW
      return "You have submited a request for help finding this Item. Someone will begin the process shortly."
    when STATUS_SEARCH_IN_PROGRESS
      return "#{assigned_to_name} is searching for this Item. If it is found, we'll contact you as soon as possible."
    when STATUS_ESCALATED_TO_LEVEL_2
      return "#{assigned_to_name} looked for this Item and couldn't find it. We're going to look for the Item again as soon as possible."
    when STATUS_REVIEW_BY_COORDINATOR
      return  "We've a few times and couldn't find the item. The coordinator will review search history and decide how to proceed next."
    when STATUS_RESOLVED
      return patron_ticket_resolution_description
    else
      return "Something has gone wrong. This ticket doesn't have a status attached. Please contact us to report this problem."
    end
  end

  def patron_ticket_resolution_description
    case resolution
    when SearchTicket::RESOLUTION_FOUND
      return "We've located this item and it's been placed on hold for you at #{location_name}."
    when SearchTicket::RESOLUTION_NOT_FOUND
      return "We've performed several, thorough searches and unfortunatelly, we could not find this item. We will contact you with next steps."
    when SearchTicket::RESOLUTION_CANCELLED
      return "We've cancelled this ticket. Please refer to notes for the detailed explanation."
    when SearchTicket::RESOLUTION_DUPLICATE
      return "This ticket is a duplicate of another one, please refer to the original for more information."
    when SearchTicket::RESOLUTION_IN_ACQUISITIONS
      return "Some one from the acquisitions department is reviewing this ticket."
    when SearchTicket::RESOLUTION_REPURCHAISING
      return "We have decided to repurchase this item. It will be available in the near future."
    when SearchTicket::RESOLUTION_DECLARED_MISSING
      return "We no longer keep a copy of this item in the library."
    else
      return "The status of this ticket is unknown at the moment. Please refer to search history for more details."
    end
  end

  private

  def set_status_and_resolution_before_create
    status = STATUS_NEW
    resolution = RESOLUTION_UNKNOWN
  end


end
