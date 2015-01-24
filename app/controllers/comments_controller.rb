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

private
  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
