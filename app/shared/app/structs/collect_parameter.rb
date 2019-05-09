class CollectParameter < Dry::Struct
  attribute :signedin_at,      Types::Strict::Time
  attribute :collect_method,   Types::Strict::Symbol
  attribute :archive_url,      Types::Strict::String.optional
  attribute :protect_reply,    Types::Strict::Bool
  attribute :protect_favorite, Types::Strict::Bool
  attribute :collect_from,     Types::Strict::Date.optional
  attribute :collect_to,       Types::Strict::Date.optional
end
