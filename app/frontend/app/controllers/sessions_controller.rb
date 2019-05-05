class SessionsController < ApplicationController
  rescue_from Exception, with: :invalid_session_exception

  def create
    signin = SigninForm.new(auth_hash)

    if signin.valid?
      signin.save!

      session[:user_id] = signin.id
      redirect_to new_order_path
    else
      reset_session
      redirect_to root_path, alert: '認証が正しく行われませんでした'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, alert: 'ログアウトしました'
  end

  def failure
    reset_session
    redirect_to root_path, alert: '認証が正しく行われませんでした'
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
