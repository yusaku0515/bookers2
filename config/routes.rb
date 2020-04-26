Rails.application.routes.draw do
  devise_for :users #上の方が優先順位が上がる
  root 'homes#top'
  resources :users, only: [:show, :edit, :update, :index]

  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  get '/' => 'homes#top'
  get 'home/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

