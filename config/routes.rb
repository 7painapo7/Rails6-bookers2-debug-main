Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  devise_for :users
  resources :books do#, only: [:index,:show,:edit,:create,:destroy,:update]
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  # resources :users#, only: [:index,:show,:edit,:update]

  resources :users do
    resource :relationships, only: [:create, :destroy]
  end
  get "home/about"=>"homes#about"
  get "follow/:user_id"=>"relationships#follow", as: :follow
  get "follower/:user_id"=>"relationships#follower", as: :follower
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
