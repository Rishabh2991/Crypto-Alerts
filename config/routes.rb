require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"

  get "home", to: "home#index"
  get "alerts", to: "alerts#index",as: :alerts_page
  get "alerts/new", to: "alerts#new", as: :new_alerts
  post "alerts", to: "alerts#create"

  post "wallets", to: "wallets#transact"

  mount Sidekiq::Web => '/sidekiq'
end
