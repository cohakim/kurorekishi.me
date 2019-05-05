class SigninForm < Reform::Form
  property :id, from: :uid

  property :info do
    property :nickname
    validates :nickname, presence: true
  end

  property :credentials do
    property :token
    property :secret
    validates :token, :secret, presence: true
  end
end
