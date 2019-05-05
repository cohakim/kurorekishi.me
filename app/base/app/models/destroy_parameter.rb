class DestroyParameter < OpenStruct
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :start_message
  attribute :finish_message

  def self.construct(*args)
    attrs = %i(start_message finish_message)
    new(Hash[*attrs.flat_map { |attr| [attr, args.shift] }])
  end
end
