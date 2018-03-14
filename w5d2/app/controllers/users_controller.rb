class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  # def destroy
  # end
  #
  # def edit
  # end
  #
  # def update
  # end
  #
  def show
    @user = User.find(params[:id])
  end

  # def index
  # end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
