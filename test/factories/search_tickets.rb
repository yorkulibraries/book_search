FactoryBot.define do
  factory :search_ticket do

    sequence(:item_id) { |n| n+1230000 }
    sequence(:item_callnumber) { |n| "CF BD 20#{n+20}" }
    sequence(:item_title) { |n| "Item Title Title - #{n}" }
    sequence(:item_author) { |n| "Johnno Smithy the #{n}" }

    sequence(:item_year) { |n| "200#{n}" }
    sequence(:item_volume) { |n| "Vol. #{n}" }
    sequence(:item_issue) { |n| "Issue #{n}" }

    resolution SearchTicket::RESOLUTION_UNKNOWN
    status SearchTicket::STATUS_NEW
    note "Some NOTE"

    ## associations
    association :patron, factory: :patron
    association :assigned_to, factory: :employee
    association :location, factory: :location

    # set the location name to be the same as the generate location
    sequence(:item_location) { location.ils_code if location }

  end
end
