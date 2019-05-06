Rails.application.routes.draw do
  scope '/cleaner' do
    scope '/v1' do
    end

    scope '/v1i', module: :internal do
      resources :users, only: :show
      resources :orders, only: :show
    end
  end
end
