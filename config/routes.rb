Rails.application.routes.draw do

  resources :purchase_orders, :only => [:index, :show] do
    resources :line_items, :only => [:create, :destroy]
  end

  resources :items do
    collection do
      get :autocomplete
    end
  end

  root 'purchase_orders#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
