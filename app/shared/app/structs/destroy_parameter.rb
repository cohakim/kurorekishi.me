class DestroyParameter < Dry::Struct
  attribute :start_message,  Types::Strict::String
  attribute :finish_message, Types::Strict::String
end
