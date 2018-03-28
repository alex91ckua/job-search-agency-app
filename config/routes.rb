Rails.application.routes.draw do
  root 'home#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :jobs, only: [:index, :show]
  resources :companies, only: [:index, :show]
  resource :candidate, only: [:create]
end
