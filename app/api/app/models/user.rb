# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  token           :string(255)      not null
#  secret          :string(255)      not null
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  class << self
    def find_by_application_token(token)
      user_id = extract_user_id_from_token(token)
      find_by(id: user_id)
    rescue JWT::VerificationError, JWT::DecodeError
      nil
    end

    private

    def extract_user_id_from_token(token)
      payload = extract_payload_from_token(token)
      payload.fetch('user_id')
    end

    def extract_payload_from_token(token)
      JWT.decode(
        token,
        Rails.application.secrets.secret_key_base,
        'HS256'
      ).first
    end
  end

  def application_token
    JWT.encode(
      {
        user_id: id,
        iat: updated_at.to_i,
      },
      Rails.application.secrets.secret_key_base,
      'HS256'
    )
  end
end
