class SessionsController < ApplicationController
  rescue_from Exception, with: :invalid_session_exception

  def create
    signin = SigninForm.new(auth_hash)

    if signin.valid?
      signin.save!

      application_token = signin.user.application_token
      redirect_to "#{params[:linkingurl]}/?application_token=#{application_token}"
    end
  end

  protected

  def invalid_session_exception(ex)
    reset_session
    raise ex
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
