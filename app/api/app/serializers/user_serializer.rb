class UserSerializer < ActiveModel::Serializer
  attribute :id

  has_one :user_info
  has_one :credentials do
    {
      access_token: object.token,
      access_token_secret: object.secret,
    }
  end
end
