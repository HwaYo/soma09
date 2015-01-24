class PostsController < ApplicationController
  def index
    @new_post = Post.new
    @posts = Post.latest
  end

  def create
    @new_post = Post.new(post_params)
    @user = current_user

    @new_post.user = @user

    if @new_post.save
      redirect_to posts_path
    else
      @posts = Post.latest
      render 'index'
    end
  end

  private
    def post_params
      params.require(:post).permit(:link, :content)
    end
end
