Rails.application.routes.draw do



  namespace :sl1 do
    resources :new_requests, only: :index
    resource :start_search, only: [:update, :put]
    resources :my_search_requests, only: :index
    resource :search_attempt, only: [:new, :create, :show]
  end


  resources :patrons
  resources :employees
  resources :locations
  resources :search_areas

  root "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
