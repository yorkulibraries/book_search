class Location < ApplicationRecord
  # attributes:  name, email, address, phone

  ## CONSTANTS

  ## VALIDATIONS
  validates_presence_of :name, :email, :ils_code

  ## RELATIONS
  has_many :tickets, class_name: "SearchTicket"
  has_many :employees
  has_many :search_areas


  ## SCOPES

  ## METHODS

end
