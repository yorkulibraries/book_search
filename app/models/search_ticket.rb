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

  RESOLUTIONS = [RESOLUTION_UNKNOWN, RESOLUTION_FOUND, RESOLUTION_NOT_FOUND, RESOLUTION_CANCELLED, RESOLUTION_DUPLICATE]
  STATUSES = [STATUS_NEW, STATUS_SEARCH_IN_PROGRESS, STATUS_ESCALATED_TO_LEVEL_2, STATUS_RESOLVED]

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
  scope :under_review_tickets, -> { where(status: STATUS_REVIEW_BY_COORDINATOR) }

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
      return {
        title: "Just In",
        description: "#{patron_name} has submitted this ticket. Click Start Search button to assign this ticket to your self and begin your search."
      }
    when STATUS_SEARCH_IN_PROGRESS
      return {
        title: "Search In Progress",
        description: "#{assigned_to_name} is searching for this Item. If it is found, we'll update the patron."
      }
    when STATUS_ESCALATED_TO_LEVEL_2
      return {
        title: "Initial Search Unsuccessful",
        description: "#{assigned_to_name} looked for this item and couldn't find it. This ticket has been escalated to our Level Two staff."
      }
    when STATUS_REVIEW_BY_COORDINATOR
      return {
        title: "After 2 Searches Item is still missing",
        description: "#{assigned_to_name} couldn't find the item. The coordinator will review search history and decide how to proceed next."
      }
    when STATUS_RESOLVED
      return ticket_resolution_description
    else
      return {
        title: "Unknown Status",
        description: "Something has gone wrong. This ticket doesn't have a status attached. Please contact your admin to report this problem."
      }
    end
  end

  def ticket_resolution_description
    case resolution
    when SearchTicket::RESOLUTION_FOUND
      return {
        title: "This Item Has Been Found",
        description: "We've located this item and it has been placed on hold for the patron."
      }
    when SearchTicket::RESOLUTION_NOT_FOUND
      return {
        title: "We couldn't find this item",
        description: "We've performed several, thorough search and unfortunatelly, we could not find this item. Please see your email for addtional options."
      }
    when SearchTicket::RESOLUTION_CANCELLED
      return {
        title: "This Search Ticket has been cancelled",
        description: "We've cancelled this ticket. Please refer to notes for the detailed explanation."
      }
    when SearchTicket::RESOLUTION_DUPLICATE
      return {
        title: "Duplicate Search Ticket",
        description: "This ticket is a duplicate of another one, please refer to the original for more information."
      }
    else
      return {
        title: "Search Ticket Resolution: #{resolution.humanize}",
        description: "The status of this ticket is unknown at the moment. Please refer to search history for me details."
      }
    end
  end

  private

  def set_status_and_resolution_before_create
    status = STATUS_NEW
    resolution = RESOLUTION_UNKNOWN
  end


end
