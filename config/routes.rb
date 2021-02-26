Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }, controllers: { registrations: "users/registrations" }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/users' => 'pages#user', as: :user_root # creates user_root_path

  resources :videos, only: [:index, :show] do
    collection do
      get 'difficulty/:level', action: :difficulty, as: 'difficulty_filter'
    end
  end

  resources :orders, only: [:new, :create, :destroy]

  resources :purchases, only: [:index, :show, :create, :destroy] do
    resources :payments, only: [:new]
    get '/payments/success', to: 'payments#success'
    get '/payments/cancel', to: 'payments#cancel'
  end

  mount StripeEvent::Engine, at: '/stripe-webhooks'

  get '/cart', to: 'orders#checkout'

  get '/confirm', to: 'orders#confirm'

  get '/myprofile', to: 'pages#myprofile'

  get '/payment', to: 'pages#payment'

  post '/workout', to: 'pages#workout'

  resources :goals do
    member do
      patch 'comment', action: :comment, as: 'comment'
    end
  end
  get '/instructors', to: 'pages#instructors'
end
