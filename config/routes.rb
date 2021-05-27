Rails.application.routes.draw do
  get 'cards/new'
  root "items#index"
  get 'items/search'
  devise_for :users
  resources :items do
    resources :orders
  end
  resources :users, only: [:show, :update]
  resources :cards, only: [:new, :create]
  resources :carts
end
