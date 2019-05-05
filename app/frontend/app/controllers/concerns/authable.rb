module Authable
  extend ActiveSupport::Concern

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    reset_session
  end

  def logged_in?
    current_user.present?
  end
end
