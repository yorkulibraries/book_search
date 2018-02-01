FactoryBot.define do
  factory :patron do
    name "John Doe"
    sequence(:email) { |n| "john_doe#{n}@test.yorku.email" }    
    sequence(:login_id) { |n| "2001#{n+10000}" }
  end
end
