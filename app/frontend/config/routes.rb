Rails.application.routes.draw do
  root to: 'roots#redirect_to_getstarted'

  scope 'cleaner' do
    get '/getstarted', to: 'roots#show', as: :getstarted

    get '/auth/twitter', as: :signin
    get '/auth/:provider/callback', to: 'sessions#create'

    resource :order, only: [:show, :new, :create, :abort, :confirm, :close] do
      get :result, on: :member
      patch :abort, on: :member
      patch :confirm, on: :member
      patch :close, on: :member
    end
  end
end
