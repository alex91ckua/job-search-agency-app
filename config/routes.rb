Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  resources :jobs, only: [:index, :show]
  resources :landing_pages, only: [:show, :create], :path => '/landing'
  resources :companies, only: [:index, :show]
  resources :articles, only: [:index, :show]
  resources :podcasts, only: [:index, :show]
  resource :candidate, only: [:create]
  get 'client-services', to: 'client_services#index'
  get 'join-us', to: 'join_us#index'
  post 'join-us', to: 'join_us#create'
  get 'contact-us', to: 'contact_us#index'
  get 'about-us', to: 'about_us#index'
  get 'diversity-and-inclusion', to: 'diversity#index'
  get 'privacy-policy', to: 'privacy_policy#index'
  get 'thanks-for-callback-apply', to: 'request_callback#thanks_for_apply'
  get 'thanks-for-cv-apply', to: 'request_callback#thanks_for_apply'
  get 'academy', to: 'academy#index'
  post 'academy', to: 'academy#create'

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
  get '/blog', to: redirect('/articles', status: 301)
  get '/news', to: redirect('/articles', status: 301)
  get '/testimonials', to: redirect('/about-us', status: 301)
  get '/term-of-use', to: redirect('/', status: 301)
  get '/finance-accounting', to: redirect('/', status: 301)
  get '/finance-systems-and-projects', to: redirect('/', status: 301)
  get '/methods', to: redirect('/about-us', status: 301)
  get '/team', to: redirect('/about-us', status: 301)
  get '/vacancies', to: redirect('/jobs', status: 301)
  get '/contact', to: redirect('/contact-us', status: 301)
  get '/finance-accounting', to: redirect('/about-us', status: 301)

  # sitemap redirect
  get '/sitemap.xml', to: redirect('https://s3.eu-west-2.amazonaws.com/global-accounting-network/sitemaps/sitemap.xml.gz',
                                   status: 301)

  get '/analytics.txt', to: 'statics#analytics'

  match '*path' => redirect('/'), via: :get unless Rails.env.development?
end
