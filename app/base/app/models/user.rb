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
  has_many :entries, dependent: :destroy

  composed_of :user_info, class_name: 'UserInfo', constructor: :construct,
    mapping: [%w(id uid), %w(name nickname)]

  composed_of :credentials, class_name: 'Credential', constructor: :construct,
    mapping: [%w(token access_token), %w(secret access_token_secret)]
end
