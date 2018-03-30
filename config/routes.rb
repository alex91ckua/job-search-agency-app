Rails.application.routes.draw do
  root 'home#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :jobs, only: [:index, :show]
  resources :companies, only: [:index, :show]
  resource :candidate, only: [:create]
  get 'client-services', to: 'client_services#index'
  scope 'client-services' do
    get 'request-callback', to: 'request_callback#index'
    post 'request-callback', to: 'request_callback#create'
  end

end
