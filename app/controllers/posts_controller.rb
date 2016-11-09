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
  
  def new
      @post = Post.new
  end
  
  def create
      @post = Post.create(post_params)
      if @post.save!
          redirect_to @post
      else
          //
      end
  end
  
  def update
      curr_post = Post.find_by_id(params[:id])
      if curr_post.update!(post_params)
          redirect_to curr_post
      else
          //
      end
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
  
  
end
