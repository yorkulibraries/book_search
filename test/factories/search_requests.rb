FactoryBot.define do
  factory :search_request do

    sequence(:item_id) { |n| n+1230000 }
    sequence(:item_callnumber) { |n| "CF BD 20#{n+20}" }
    sequence(:item_title) { |n| "Item Title Title - #{n}" }
    resolution SearchRequest::RESOLUTION_UNKNOWN
    status SearchRequest::STATUS_OPEN
    note "Some NOTE"

    ## associations
    association :patron, factory: :patron
    association :assigned_to, factory: :employee
    location_id 1

  end
end
