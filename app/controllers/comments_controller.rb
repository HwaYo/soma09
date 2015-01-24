class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to posts_path
    end
  end

private
  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end
end
