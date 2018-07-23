Rails.application.routes.draw do

  get "login/invalid" => "invalid_login#show", as: :invalid_login
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
  get "redirector" => "redirectr#index"
  get "dashboard" => "dashboard#index"

  namespace :print do
    get 'tickets_to_search' => "tickets_to_search#index"
  end

  namespace :sl2 do
    resource :dashboard, only: :show, controller: "dashboard"
    resources :search_ticket, only: [:edit, :update, :show]
  end

  namespace :patron do
    resources :request_search, only: [:new, :create, :show, :index]
    resources :my_tickets, only: [:index, :show]
  end

  namespace :sl1 do

    resource :dashboard, only: :show, controller: "dashboard"

    resources :new_tickets, only: :index
    resources :in_progress_tickets, only: :index
    resources :escalated_tickets, only: :index
    resources :resolved_tickets, only: :index

    resource :start_search, only: [:update, :put]
    resources :assigned_to_me_tickets, only: :index
    resources :search_ticket, only: [:edit, :update, :show]

  end

  namespace :admin do
    resources :patrons
    resources :employees
    resources :locations
    resources :search_areas
  end

  root "redirector#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
