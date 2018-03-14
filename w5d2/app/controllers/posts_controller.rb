class PostsController < ApplicationController

  before_action :ensure_author, only: [:update, :edit]

  def ensure_author
    unless Post.find(params[:id]).author==current_user
      flash[:errors] = ['Cant edit a post you dont own ']
      redirect_to post_url(@post)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to post_url(@post)
    else
      flash[:errors] = @past.errors.full_messages
      redirect_to edit_post_url(@post)
    end
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
  end

  def destroy
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @subs = Sub.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_post_url
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
