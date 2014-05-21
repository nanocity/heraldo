Heraldo::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    delete 'users/sign_out', to: 'omniauth_callbacks#destroy'
    resources :users, only: [ :edit, :update ]
  end

  resources :tournaments do
    member do
      get :management
    end
  end

  resources :subscriptions, only: [ :create, :destroy ]
  resources :armies, only: [ :update ]
  resources :comments, only: [ :create ]

  get 'dashboard', to: 'dashboard#index'

  root 'tournaments#index'
end
