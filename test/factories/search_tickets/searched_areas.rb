FactoryBot.define do
  factory :searched_area, class: 'SearchTicket::SearchedArea' do

    work_log nil
    association :search_area, factory: :search_area
    association :search_ticket, factory: :search_ticket  
  end
end
