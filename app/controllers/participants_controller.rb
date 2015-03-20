class ParticipantsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    participant = @post.participants.find_or_initialize_by(user: current_user)
    participant.save!
    subject = "#{current_user.name}님이 공동구매에 참여하였습니다."
    content = <<-eos
      <p>#{current_user.name}님이 공동구매에 참여하였습니다.</p>
      <p>
        자세한내용은 <a href="http://soma09.herokuapp.com">여기</a>에 가서 확인해주세요!
      </p>
    eos

    content = content.gsub /^\s+/, ""
    @post.participants.send_notification(@post, current_user, subject, content)

    redirect_to posts_path

  rescue ActiveRecord::RecordInvalid
    if participant.errors[:too_many_participant].any?
      redirect_to posts_path, alert: "인원 초과입니다."
    end
  end

  def destroy
    participant = Participant.find_by_id(params[:id])

    if participant and participant.user == current_user
      participant.destroy
    end

    redirect_to posts_path
  end
end