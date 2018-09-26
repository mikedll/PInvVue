Rails.application.routes.draw do
  resources :purchase_orders, :only => [:index]

  root 'purchase_orders#index'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
