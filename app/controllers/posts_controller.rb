class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.find_by(author_id: params[:user_id])
  end

  def show
    @post = Post.find_by(author_id: params[:user_id], id: params[:id])
  end
end