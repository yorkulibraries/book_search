FactoryBot.define do
  factory :work_log, class: SearchTicket::WorkLog do
    result SearchTicket::WorkLog::RESULT_UNKNOWN
    found_location nil
    note "Some NOTE"
    work_type SearchTicket::WorkLog::WORK_TYPE_SEARCH

    ## associations
    association :employee, factory: :employee
    association :search_ticket, factory: :search_ticket

    after(:build) do |log|
      log.searched_areas.push build(:searched_area)
    end
  end
end
