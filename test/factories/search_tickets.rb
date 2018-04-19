FactoryBot.define do
  factory :search_ticket do

    sequence(:item_id) { |n| n+1230000 }
    sequence(:item_callnumber) { |n| "CF BD 20#{n+20}" }
    sequence(:item_title) { |n| "Item Title Title - #{n}" }
    resolution SearchTicket::RESOLUTION_UNKNOWN
    status SearchTicket::STATUS_NEW
    note "Some NOTE"

    ## associations
    association :patron, factory: :patron
    association :assigned_to, factory: :employee
    location_id 1

  end
end
