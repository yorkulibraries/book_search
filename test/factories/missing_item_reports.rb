FactoryBot.define do
  factory :missing_item_report do

    sequence(:item_id) { |n| {n+1230000} }
    sequence(:item_callnumber) { |n| "CF BD 20#{n+20}" }
    sequence(:item_title) { |n| "Item Title Title - #{n}" }
    resolution MissingItemReport::RESOLUTION_UNKNOWN
    status MissingItemReport::STATUS_OPEN
    note "Some NOTE"
    ## associations
    patron_id 1
    location_id 1

  end
end
