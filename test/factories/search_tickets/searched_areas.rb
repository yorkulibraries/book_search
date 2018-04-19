FactoryBot.define do
  factory :search_ticket_searched_area, class: 'SearchTicket::SearchedArea' do
    search_area_id 1
    search_ticket_search_attempt_id 1
    search_ticket_id 1
  end
end
