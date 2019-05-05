class CollectParameter < OpenStruct
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :signedin_at
  attribute :collect_method
  attribute :archive_url
  attribute :protect_reply
  attribute :protect_favorite
  attribute :collect_from
  attribute :collect_to

  def self.construct(*args)
    attrs = %i(signedin_at collect_method archive_url protect_reply protect_favorite collect_from collect_to)
    new(Hash[*attrs.flat_map { |attr| [attr, args.shift] }])
  end
end
