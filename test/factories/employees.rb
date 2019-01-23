FactoryBot.define do
  factory :employee do
    sequence(:name) { |n| "#{n} John Doe" }
    sequence(:email) { |n| "john_doe#{n}@employees.yorku.email" }
    sequence(:login_id) { |n| "2002#{n+10000}" }
    role Employee::ROLE_MANAGER
    active true
    location { create(:location)}
  end
end
