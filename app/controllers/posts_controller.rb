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

  def close
    @post = Post.find(params[:id])
    @post.update(closed: true)

    redirect_to posts_path
  end

  def open
    @post = Post.find(params[:id])
    @post.update(closed: false)

    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:link, :content)
    end
end
