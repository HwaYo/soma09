class ParticipantsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    participant = @post.participants.find_or_initialize_by(user: current_user)
    participant.save!
    

    message = "#{current_user.name}님이 공동구매에 참여하였습니다."
    @post.participants.send_notification(@post, current_user, message)
    
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