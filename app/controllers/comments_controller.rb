class CommentsController < ApplicationController
  before_action :find_post

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      subject = "#{current_user.name}님이 참여한 공동구매에 댓글을 달았습니다."
      content = <<-eos
        <p>#{current_user.name}님이 참여한 공동구매에 댓글을 달았습니다.</p>
        <p>
          자세한내용은 <a href="http://soma09.herokuapp.com">여기</a>에 가서 확인해주세요!
        </p>
      eos

      content = content.gsub /^\s+/, ""

      @post.participants.send_notification(@post, current_user, subject, content)

      redirect_to posts_path
    else
      @new_post = Post.new
      @posts = Post.latest
      render 'posts/index'
    end
  end

  def update
    @comment = @post.comments.find(params[:id])

    @comment.update!(comment_params)

    redirect_to posts_path
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to posts_path
  end

private
  def comment_params
    params.require(:comment).permit(:post_id, :content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
