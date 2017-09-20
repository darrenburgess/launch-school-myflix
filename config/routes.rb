Myflix::Application.routes.draw do
  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'
  get 'home', to: "videos#index"

  resources :videos, only: [:index, :show] do
    collection do
      get 'search'
    end

    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show]
  resources :users, only: [:create]
  get 'register', to: "users#new"

  resources :queue_items, only: [:index]

  get 'signin', to: "sessions#new"
  post 'signin', to: "sessions#create"
  get 'signout', to: "sessions#destroy"
end
