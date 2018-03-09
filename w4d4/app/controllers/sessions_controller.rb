class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if user
      login!(user)
      redirect_to user_url(user)
    else
      flash[:errors] = ['Email/Password combination does not exist']
      render :new
    end
  end

  def update
  end

  def edit
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  def show
  end

  def index
  end
end
