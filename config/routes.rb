Rails.application.routes.draw do

  get 'missing_items_report/index'

  root "dashboard#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
