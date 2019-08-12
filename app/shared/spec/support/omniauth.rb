def set_omniauth(user = nil)
  OmniAuth.config.test_mode = true
  if user == :invalid_user
    OmniAuth.config.mock_auth[:twitter] = omniauth_invalid_credentials
  else
    OmniAuth.config.mock_auth[:twitter] = omniauth_valid_credentials(user)
  end
end

def omniauth_valid_credentials(user = nil)
  OmniAuth::AuthHash.new({
    provider: 'twitter',
    uid:      user.try(:id) || '9223372036854775807',
    credentials: {
      'token': "#{user.try(:id)}-token",
      'secret': 'secret'
    },
    info: {
      nickname: user.try(:nickname) || 'johnqpublic',
      name:     'John Q Public',
    },
    extra: {
      raw_info: {
        statuses_count: 7777,
        created_at:     'Thu Jul 4 00:00:00 +0000 2013',
      }
    }
  })
end

def omniauth_invalid_credentials
  OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
end
