Myflix::Application.routes.draw do
  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'
  get 'home', to: "videos#index"

  resources :videos, only: [:index, :show] do
    collection do
      get 'search'
    end
  end

  resources :categories, only: [:show]
  resources :users, only: [:create]
  get 'register', to: "users#new"

  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  post 'logout', to: "sessions#destroy"
end
