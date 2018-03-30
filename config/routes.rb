Rails.application.routes.draw do
  root 'home#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :jobs, only: [:index, :show]
  resources :companies, only: [:index, :show]
  resource :candidate, only: [:create]
  get 'client-services', to: 'client_services#index'
  get 'contact-us', to: 'contact_us#index'
  get 'about-us', to: 'about_us#index'

  scope 'contact-us' do
    get 'contact-client', to: 'contact_client#index'
    post 'contact-client', to: 'contact_client#create'

    get 'contact-candidate', to: 'contact_candidate#index'
    post 'contact-candidate', to: 'contact_candidate#create'
  end

  scope 'client-services' do
    get 'request-callback', to: 'request_callback#index'
    post 'request-callback', to: 'request_callback#create'
  end
end
