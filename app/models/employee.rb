class Employee < ApplicationRecord
  # attributes:  name, email, location_id, role, login_id, active

  ## CONSTANTS
  ROLE_MANAGER="manager"
  ROLE_SUPERVISOR="supervisor"
  ROLE_STAFF="staff"
  ROLES = [ ROLE_MANAGER, ROLE_SUPERVISOR, ROLE_STAFF ]

  ## VALIDATIONS
  validates_uniqueness_of :login_id
  validates_presence_of :login_id, :name, :email, :role

  ## RELATIONS
  # belongs_to :location

  ## SCOPES

  ## METHODS
end
