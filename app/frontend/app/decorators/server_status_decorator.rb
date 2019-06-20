class ServerStatusDecorator < Draper::Decorator
  delegate_all

  def busyness_i18n
    I18n.t "activemodel.enums.server_status.busyness.#{object.busyness}"
  end
end
