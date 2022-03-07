Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  get '/confidentiality', to: 'pages#confidentiality'
  get '/datauser', to: 'pages#datauser'


  resources :tv_shows, only: [:index, :show, :my] do
    resources :feedbacks, only: [:create, :update]
    resources :wishes, only: [:create]
  end

  resources :users, only: [:index, :show]

  resources :wishes, only: [:index, :destroy]

  namespace :my do
    resources :tv_shows, only: :index
  end

  namespace :swipe do
    resources :tv_shows, only: :index
  end

  namespace :search do
    resources :tv_shows, only: :index
  end

  namespace :search do
    resources :users, only: :index
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
