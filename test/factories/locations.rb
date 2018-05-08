FactoryBot.define do
  factory :location do
    name "Main Library"
    address "Campus Library Walk"
    ils_code "LIBPLACE"
    sequence(:email) { |n| "main_library#{n}@test.yorku.email" }
    phone "442224424242"
  end
end
