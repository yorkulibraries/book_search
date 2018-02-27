Rails.application.routes.draw do

  namespace :missing_item_reports do
    get 'assign_to_employee/create'
  end

  namespace :missing_item_reports do
    get 'assign_to_employee/destroy'
  end

  resources :patrons
  resources :employees
  root "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
