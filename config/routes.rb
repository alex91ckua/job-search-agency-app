Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  resources :jobs, only: [:index, :show]
  resources :companies, only: [:index, :show]
  resources :articles, only: [:index, :show]
  resource :candidate, only: [:create]
  get 'client-services', to: 'client_services#index'
  get 'join-us', to: 'join_us#index'
  post 'join-us', to: 'join_us#create'
  get 'contact-us', to: 'contact_us#index'
  get 'about-us', to: 'about_us#index'

  scope 'contact-us' do
    get 'register-a-vacancy', to: 'contact_client#index'
    post 'register-a-vacancy', to: 'contact_client#create'

    get 'register-interest', to: 'contact_candidate#index'
    post 'register-interest', to: 'contact_candidate#create'
  end

  scope 'client-services' do
    get 'request-callback', to: 'request_callback#index'
    post 'request-callback', to: 'request_callback#create'
  end

  # redirects from old website page
  get '/team', to: redirect('/about-us', status: 301)
  get '/vacancies', to: redirect('/jobs', status: 301)
  get '/contact', to: redirect('/contact-us', status: 301)
  get '/finance-accounting', to: redirect('/about-us', status: 301)
end
