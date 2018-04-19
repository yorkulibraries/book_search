FactoryBot.define do
  factory :search_attempt, class: SearchTicket::SearchAttempt do
    resolution SearchTicket::SearchAttempt::RESOLUTION_UNKNOWN
    found_location nil
    note "Some NOTE"

    ## associations
    association :employee, factory: :employee
    association :search_ticket, factory: :search_ticket

  end
end
