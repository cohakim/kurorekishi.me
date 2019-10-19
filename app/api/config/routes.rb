Rails.application.routes.draw do
  scope '/cleaner' do
    scope '/v1' do
      get '/auth/twitter', as: :signin
      get '/auth/:provider/callback', to: 'sessions#create'
      resource :order, only: %i(show create)
    end
  end
end
