class ApplicationController < ActionController::Base
  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  protect_from_forgery with: :exception

  def login_user!
    @user.reset_session_token!
    session[:session_token] = @user.session_token
    redirect_to cats_url
  end

  helper_method :current_user
end
