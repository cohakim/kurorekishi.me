# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  token      :string(255)      not null
#  secret     :string(255)      not null
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
