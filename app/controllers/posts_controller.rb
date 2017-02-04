class PostsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def index
      @posts = Post.all
  end
  
  def show
      @post = Post.find_by_id(params[:id])
  end
  
  
  
  
end
