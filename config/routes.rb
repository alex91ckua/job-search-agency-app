Rails.application.routes.draw do
  root 'home#index'
  post '/home', to: 'home#create_callback', as: :create_callback
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :jobs, only: [:index, :show]
  resources :companies, only: [:index, :show]
  resource :candidate, only: [:create]
end
