# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Auth route
      root to: "products#index"
      post '/authenticate', to: 'authentication#authenticate'
      resources :addresses
      resources :customers
      resources :prices
      resources :price_lists
      resources :products
      resources :purchases
      resources :sales do
        resources :sale_lines
      end
      resources :stock_histories
      resources :suppliers
      resources :users, only: %i(show create update destroy)
    end
  end
end
