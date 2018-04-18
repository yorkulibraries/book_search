class SearchArea < ApplicationRecord
  # attributes:  :name :primary, :location_id

  ## VALIDATIONS
  validates_presence_of :name, :location

  ## RELATIONS
  belongs_to :location

  ## SCOPES
  scope :primary, -> { where(primary: true) }
  scope :secondary, -> { where(primary: false) }

end
