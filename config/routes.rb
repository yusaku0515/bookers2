Rails.application.routes.draw do
  devise_for :users #上の方が優先順位が上がる
  root 'users#show'
  resources :users, only: [:show, :edit, :update, :index]
  resources :user_images, only: [:new, :create, :index, :show, :destroy]
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  get 'top' => 'homes#top'
  get 'about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

