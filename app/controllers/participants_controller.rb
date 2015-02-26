class ParticipantsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    @post.participants.find_or_create_by(user: current_user)
    
    message = "#{current_user.name}님이 공동구매에 참여하였습니다."
    @post.participants.send_notification(@post, current_user, message)
  
    redirect_to posts_path
  end

  def destroy
    participant = Participant.find_by_id(params[:id])

    if participant and participant.user == current_user
      participant.destroy
    end

    redirect_to posts_path
  end
end