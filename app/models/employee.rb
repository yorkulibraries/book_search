class Employee < ApplicationRecord
  # attributes:  name, email, location_id, role, login_id, active

  ## CONSTANTS
  ROLE_MANAGER="manager"
  ROLE_COORDINATOR="coordinator"
  ROLE_LEVEL_ONE ="service_level_one"
  ROLE_LEVEL_TWO ="service_level_two"
  ROLES = [ ROLE_MANAGER, ROLE_COORDINATOR, ROLE_LEVEL_ONE, ROLE_LEVEL_TWO ]

  ## VALIDATIONS
  validates_uniqueness_of :login_id
  validates_presence_of :login_id, :name, :email, :role

  ## RELATIONS
  # belongs_to :location

  ## SCOPES

  ## METHODS
  def initials
    if name != nil
      return name.split(" ").map {|i|  i[0,1].capitalize }.join.ljust(2, "_")
    else
      return "##"
    end
  end
end
