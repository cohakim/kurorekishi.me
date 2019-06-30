class ParameterSerializer < ActiveModel::Serializer
  attributes %i(
    order_id
    signedin_at
    collect_method
    archive_url
    protect_reply
    protect_favorite
    collect_from
    collect_to
    start_message
    finish_message
  )
end
