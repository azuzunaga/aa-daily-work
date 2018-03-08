class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user, :login_user!, :logged_in?, :require_login

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!
    @user.reset_session_token!
    @user.update_columns(session_token: @user.session_token)
    session[:session_token] = @user.session_token
    current_user
    flash[:success] = "Logged in!"
    redirect_to cats_url
  end

  def require_login
    if logged_in?
      flash[:error] = "You are already logged in!"
      redirect_to cats_url
    end
  end

  def logged_in?
    !!current_user
  end
end
