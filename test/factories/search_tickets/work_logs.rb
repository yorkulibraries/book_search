FactoryBot.define do
  factory :work_log, class: SearchTicket::WorkLog do
    resolution SearchTicket::WorkLog::RESULT_UNKNOWN
    found_location nil
    note "Some NOTE"

    ## associations
    association :employee, factory: :employee
    association :search_ticket, factory: :search_ticket

  end
end
