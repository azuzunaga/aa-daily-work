class UsersController < ApplicationController
  before_action :require_login, only: :new

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if User.find_by(user_name: @user.user_name)
      flash[:error] = "Username already taken!"
      render :new
    else
      @user.reset_session_token!
      @user.save
      login_user!
    end
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
