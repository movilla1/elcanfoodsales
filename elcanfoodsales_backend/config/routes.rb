# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # Auth route
      post '/authenticate', to: 'authentication#authenticate'
      resources :users, only: %i[show create update destroy]
      resources :addresses
      resources :products
      resources :purchases
      resources :clients
      resources :stocks
      resources :suppliers
      resources :sales
    end
  end
end
