Rails.application.routes.draw do
  devise_for :users, only: []
  resources :furniture_items
  resources :content, only: [:index]
  resources :users, only: [:create]
  resources :sessions, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end