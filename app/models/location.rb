class Location < ApplicationRecord
  # attributes:  name, email, address, phone

  ## CONSTANTS

  ## VALIDATIONS
  validates_presence_of :name, :email, :ils_code

  ## RELATIONS
  # has_many :search_tickets
  # has_many :search_areas
  # has_many :employees

  ## SCOPES

  ## METHODS

end
