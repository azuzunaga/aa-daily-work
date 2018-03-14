class SubsController < ApplicationController
  before_action :ensure_moderator, only: [:edit, :update]

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to new_sub_url
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to edit_sub_url
    end
  end

  def destroy
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def index
    @subs = Sub.all
  end

  def ensure_moderator
    unless current_user == Sub.find(params[:id]).moderator
      flash[:errors] = ["can't edit a sub you don't own"]
      redirect_to sub_url(params[:id])
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
