Rails.application.routes.draw do

  resources :locations
  resources :search_areas
  namespace :sl1 do
    resources :new_requests, only: :index
    resource :start_search, only: [:update, :put]
    resources :my_search_requests, only: :index
  end


  resources :patrons
  resources :employees
  root "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
