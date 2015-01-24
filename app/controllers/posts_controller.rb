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

    if @post.update(closed: true)
      content = <<-eos
        참가하셨던 공동구매가 마감되었습니다!

        #{@post.link}

        #{@post.content}
      eos
      send_notification_email "참가하셨던 공동구매가 마감되었습니다!", content
    end

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

  def send_notification_email(subject, text)
    @mailgun = Mailgun()

    @post.participants.each do |participant|
      @mailgun.messages.send_email({
        to: participant.user.email,
        subject: subject,
        text: text,
        from: @post.user.email
      })
    end
  end
end