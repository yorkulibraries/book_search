FactoryBot.define do
  factory :search_area do
    name "Stacks"
    primary true
    association :location, factory: :location
  end
end
