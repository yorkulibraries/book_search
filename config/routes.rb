Rails.application.routes.draw do

  if Rails.env.development?
    get "bootstrap_docs" => "bootstrap_docs#index"
  end

  get "login/invalid" => "invalid_login#show", as: :invalid_login
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
  get "redirector" => "redirectr#index"
  get "dashboard" => "dashboard#index"

  get "search" => "search#index"
  get "search/result/:id" => "search#show", as: :search_result

  namespace :find_this_item do
    resource :legal, only: [:show], controller: "legal"
    get 'test_cases' => "legal#index" if Rails.env.development?

    resource :request_help, only: [:create, :show], controller: "request_help"
  end

  namespace :print do
    get 'tickets_to_search' => "tickets_to_search#index"
  end

  namespace :patron do
    resources :request_search, only: [:new, :create, :show, :index]
    resources :my_tickets, only: [:index, :show]
  end

  namespace :manager do
    resource :dashboard, only: :show, controller: "dashboard"
    resources :employees, only: [:show]
  end

  namespace :coordinator do
    resource :dashboard, only: :show, controller: "dashboard"
    resources :search_ticket, only: [:edit, :update, :show]
    resources :change_requestor, only: [:edit, :update]
    get 'tickets_by_status' => "tickets_by_status#index"
  end

  namespace :sl2 do
    resource :dashboard, only: :show, controller: "dashboard"
    resources :search_ticket, only: [:edit, :update, :show]
    resource :start_search, only: [:update, :put]
    resources :change_requestor, only: [:edit, :update]
    get 'tickets_by_status' => "tickets_by_status#index"
  end

  namespace :sl1 do

    resource :dashboard, only: :show, controller: "dashboard"
    resource :start_search, only: [:update, :put]
    resources :search_ticket, only: [:edit, :update, :show]

    get 'tickets_by_status' => "tickets_by_status#index"

  end

  namespace :admin do
    resources :patrons
    resources :employees
    resources :locations 
    resources :search_areas
    resources :search_tickets
  end

  root "redirector#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
