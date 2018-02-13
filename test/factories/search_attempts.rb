FactoryBot.define do
  factory :search_attempt do
    resolution SearchAttempt::RESOLUTION_UNKNOWN
    found_location nil
    note "Some NOTE"

    ## associations
    association :employee, factory: :employee
    association :missing_item_report, factory: :missing_item_report

  end
end
