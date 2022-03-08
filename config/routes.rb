Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'pages#home'
  get '/confidentiality', to: 'pages#confidentiality'
  get '/datauser', to: 'pages#datauser'


  resources :tv_shows, only: [:index, :show, :my] do
    resources :feedbacks, only: [:create, :update]
    resources :wishes, only: [:index, :create]
  end
  resources :users, only: [:index, :show]

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

  resources :watch_nows, only: [:index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
