class ParticipantsController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params[:post_id])

    @post.participants.find_or_create_by(user: @user)

    redirect_to posts_path
  end

  def destroy
    participant = Participant.find_by(params[:id])

    if participant and participant.user == current_user
      participant.destroy
    end

    redirect_to posts_path
  end
end