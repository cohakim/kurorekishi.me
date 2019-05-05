class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  include Authable

  def redirect_to_getstarted
    redirect_to getstarted_path
  end
end
