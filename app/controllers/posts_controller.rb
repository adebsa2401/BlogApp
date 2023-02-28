class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.find_by(author_id: params[:user_id])
  end

  def show
    @post = Post.find_by(author_id: params[:user_id], id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
