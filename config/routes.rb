Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
