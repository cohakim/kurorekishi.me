class ApplicationController < ActionController::API
  private

  def authenticate!
    return true if current_user.present?
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  def current_user
    @current_user ||= User.find_by_application_token(application_token)
  end

  def application_token
    request.headers['Authorization']&.split(' ')&.last
  end
end
