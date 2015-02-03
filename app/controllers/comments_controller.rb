class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to posts_path
    else
      @new_post = Post.new
      @posts = Post.latest
      render 'posts/index'
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.update(comment_params)
      redirect_to posts_path
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to posts_path
  end

private
  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
