class SigninForm < Dry::Struct
  transform_keys(&:to_sym)

  attribute :uid, Types::Params::Integer
  attribute :info do
    transform_keys(&:to_sym)
    attribute :nickname, Types::Strict::String
  end
  attribute :credentials do
    transform_keys(&:to_sym)
    attribute :token, Types::Strict::String
    attribute :secret, Types::Strict::String
  end

  def user_id
    uid
  end

  def user
    @user ||= User.find_or_initialize_by(id: user_id)
  end

  def valid?
    true
  end

  def save!
    user.name            = info.nickname
    user.token           = credentials.token
    user.secret          = credentials.secret
    user.save!
  end
end
