FactoryBot.define do
  factory :search_ticket_searched_area, class: 'SearchTicket::SearchedArea' do
    search_area_id 1
    search_ticket_work_log_id 1
    search_ticket_id 1
  end
end
