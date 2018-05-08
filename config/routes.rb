Rails.application.routes.draw do



  namespace :patron do
    resources :request_search, only: [:show, :index]
  end

  namespace :sl1 do

    resource :dashboard, only: :show, controller: "dashboard"

    resources :new_tickets, only: :index
    resources :in_progress_tickets, only: :index
    resources :escalated_tickets, only: :index
    resources :resolved_tickets, only: :index

    resource :start_search, only: [:update, :put]
    resources :my_search_tickets, only: :index
    resources :search_ticket, only: [:edit, :update, :show]

  end

  namespace :admin do
    resources :patrons
    resources :employees
    resources :locations
    resources :search_areas
  end

  root "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
