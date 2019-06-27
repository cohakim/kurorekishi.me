Rails.application.routes.draw do
  root to: 'roots#redirect_to_getstarted'
  get '/cleaner', to: 'roots#redirect_to_getstarted'

  direct :blog do
    'http://blog.kurorekishi.me'
  end
  scope 'cleaner' do
    get '/getstarted', to: 'roots#show',    as: :getstarted
    get '/usage',      to: 'roots#usage',   as: 'usage'
    get '/faq',        to: 'roots#faq',     as: 'faq'
    get '/terms',      to: 'roots#terms',   as: 'terms'
    get '/privacy',    to: 'roots#privacy', as: 'privacy'
    get '/contact',    to: 'roots#contact', as: 'contact'

    get '/auth/twitter', as: :signin
    get '/auth/:provider/callback', to: 'sessions#create'
    get '/signout', as: :signout, to: 'sessions#destroy'

    resource :order, only: [:show, :new, :create] do
      get :progressbar, on: :member
      get :status_dialog, on: :member
      get :result, on: :member
      patch :abort, on: :member
      patch :confirm, on: :member
      patch :close, on: :member
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
