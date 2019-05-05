class UserInfo
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :nickname

  def self.construct(nickname)
    new(nickname: nickname)
  end
end
