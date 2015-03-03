class PostsController < ApplicationController
  def index
    @new_post = Post.new
    @posts = Post.latest
    @notifications = current_user.notifications.last(8).reverse
    @notification_size = current_user.notifications.select{|notification| notification.read == false }.size
  end

  def create
    @new_post = Post.new(post_params)

    @new_post.user = current_user
    @new_post.participants.build(user: current_user)

    if @new_post.link.index("http://") == nil && @new_post.link.index("https://") == nil
      @new_post.link = "http://" + @new_post.link
    end
    
    if @new_post.save
      redirect_to posts_path
    else
      @posts = Post.latest
      render 'index'
    end
  end

  def edit
    @post = Post.find(params[:id])
    render partial: "edit_modal"
  end

  def update
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      redirect_to posts_path
    else
      render partial: "edit_modal", status: 500
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path, notice: "정상적으로 삭제하였습니다."
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

      message = "참가하셨던 공동구매가 마감되었습니다!"
      @post.participants.send_notification(@post, @post.user, message)

    end

    redirect_to posts_path
  end

  def open
    @post = Post.find(params[:id])

    @post.update(closed: false)

    redirect_to posts_path
  end

  def thumbnail
    @post = Post.find(params[:id])

    generate_thumbnail! unless @post.thumbnail
    render json: @post.thumbnail
  end

private
  def post_params
    params.require(:post).permit(:link, :content, :max_participant_number)
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

  def generate_thumbnail!
    link_thumbnail = LinkThumbnailer.generate(@post.link)
    @post.build_thumbnail({
      link: @post.link,
      title: link_thumbnail.title,
      description: link_thumbnail.description,
      images: link_thumbnail.images.map { |image| image.src.to_s }
    })
    @post.save!

  # TODO: Fix invalid byte sequence problem (from gem)
  rescue ArgumentError, LinkThumbnailer::BadUriFormat => e
    @post.build_thumbnail
  end
end