class ParameterDecorator < Draper::Decorator
  delegate_all

  def protect_reply_i18n
    object.protect_reply ? 'Yes' : 'No'
  end

  def protect_favorite_i18n
    object.protect_favorite ? 'Yes' : 'No'
  end
end
