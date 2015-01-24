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
        <p>참가하셨던 공동구매가 마감되었습니다!</p>
        <p>
          <a href="http://soma09.herokuapp.com">여기</a>에 가서 확인해주세요!
        </p>
        <p>
          <a href="#{@post.link}">상세보기</a>
        </p>
        <p>
          #{@post.content}
        </p>
      eos

      content = content.gsub /^\s+/, ""

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
        html: text,
        from: @post.user.email
      })
    end
  end
end