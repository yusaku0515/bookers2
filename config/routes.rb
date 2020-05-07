Rails.application.routes.draw do
  get 'searchs/search'
  get 'relationships/create'
  get 'relationships/destroy'
  devise_for :users #上の方が優先順位が上がる
  root 'homes#top'
  resources :users, only: [:show, :edit, :update, :index] do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  resources :books, only: [:index, :show, :create, :edit, :update, :destroy] do
  resource :book_comments, only: [:create, :destroy]
  resource :favorites, only: [:create, :destroy]
  end

  get '/' => 'homes#top'
  get 'home/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

