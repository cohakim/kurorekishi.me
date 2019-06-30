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

class User < ApplicationRecord
  composed_of :credentials,
    mapping: [%w(token access_token), %w(secret access_token_secret)],
    constructor: ->(token, secret) {
      Credential.new(access_token: token, access_token_secret: secret)
    }
end
