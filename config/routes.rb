Rails.application.routes.draw do

  namespace :sl1 do
    resources :new_requests, only: :index
  end


  resources :patrons
  resources :employees
  root "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
