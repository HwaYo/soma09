class NotificationsController < ApplicationController
  
  def self.send_notification(post, send_user, message)
    post.participants.each do |participant|
      next if participant.user == send_user

      Notification.create!({
        message: message,
        target_user: participant.user,
        send_user: send_user,
        post: post
      })
    end
  end

  def update() 
    @notification = Notification.find(params[:id])
    
    @notification.update(read: params[:read])

    render plain: {success: true}
  end

  
end
