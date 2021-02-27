Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' }, controllers: { registrations: "users/registrations" }
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :videos, only: [:index, :show] do
    collection do
      get 'difficulty/:level', action: :difficulty, as: 'difficulty_filter'
    end
    resources :reviews, only: [:create, :new, :destroy]
  end
  resources :orders, only: [:new, :create, :destroy]
  get '/cart', to: 'orders#checkout'

  get '/confirm', to: 'orders#confirm'

  get '/myprofile', to: 'pages#myprofile'

  get '/payment', to: 'pages#payment'

end
