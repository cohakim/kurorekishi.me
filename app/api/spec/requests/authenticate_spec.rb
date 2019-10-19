require 'rails_helper'

describe OrdersController, type: :request do
  let!(:user) { create :user }
  let(:token) do
    JWT.encode(
      {
        id: user.id
      },
      Rails.application.credentials.config[:secret_key_base],
      'HS256'
    )
  end

  before do
    Rails.application.credentials.config[:secret_key_base] = 'dummy'
  end

  it '' do
    headers = {
      'Authorization': "Bearer #{token}"
    }
    get '/cleaner/v1/orders/1', params: {}, headers: headers
    expect(response.body).to eq {}
  end
end
