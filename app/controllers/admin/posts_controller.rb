class Admin::PostsController < ApplicationController
    before_action :authenticate_user

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
          redirect_to admin_post_path(@post)
      else
          flash[:error] = "Couldn't create post"
          render :new
      end
  end
  
  def update
      curr_post = Post.find_by_id(params[:id])
      if curr_post.update!(post_params)
          redirect_to admin_post_path(curr_post)
      else
          flash[:error] = "Couldn't update post"
          render :edit
      end
  end
  
  def destroy
      curr_post = Post.find_by_id(params[:id])
      if curr_post.destroy
          redirect_to admin_posts_path
      else
          flash.now[:error] = "Couldn't destroy post"
      end
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
