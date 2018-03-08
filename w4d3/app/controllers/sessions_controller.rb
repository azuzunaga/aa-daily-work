class SessionsController < ApplicationController
before_action :require_login, only: :new

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params)

    if @user
      login_user!
    else
      flash[:error] = "Invalid username/password combination"
      render :new
    end
  end

  def destroy
    @current_user.reset_session_token! if @current_user
    session[:session_token] = nil
    render :new
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
