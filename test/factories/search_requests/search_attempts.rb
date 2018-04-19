FactoryBot.define do
  factory :search_attempt, class: SearchRequest::SearchAttempt do
    resolution SearchRequest::SearchAttempt::RESOLUTION_UNKNOWN
    found_location nil
    note "Some NOTE"

    ## associations
    association :employee, factory: :employee
    association :search_request, factory: :search_request

  end
end
