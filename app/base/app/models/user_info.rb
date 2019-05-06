class UserInfo
  # TODO: User model に保存する
  attr_accessor :nickname, :registered_at, :last_sign_in_at

  def initialize(attributes)
    @nickname = attributes[:nickname]
  end

  def self.construct(nickname)
    new(nickname: nickname)
  end
end
