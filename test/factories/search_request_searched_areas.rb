FactoryBot.define do
  factory :search_request_searched_area, class: 'SearchRequest::SearchedArea' do
    search_area_id 1
    search_request_search_attempt_id 1
    search_request_id 1
  end
end
