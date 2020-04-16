Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :books, only: [:new, :create, :index, :show]
  resources :users, only: [:show]
  resources :user_images, only: [:new, :create, :index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
