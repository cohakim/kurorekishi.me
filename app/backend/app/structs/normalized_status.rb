class NormalizedStatus < Dry::Struct
  attribute :id,                  Types::Strict::Integer
  attribute :text,                Types::Strict::String
  attribute :created_at,          Types::JSON::Time
  attribute :in_reply_to_user_id, Types::Strict::Integer.optional
  attribute :favorite_count,      Types::Strict::Integer
end
