class NotificationsController < ApplicationController
  def self.send_notification(post, send_user, message)
    post.participants.each do |participant|
      unless participant.user == send_user
        @notification = Notification.new

        @notification.message = message

        @notification.target_user = participant.user
        @notification.send_user = send_user
        @notification.post = post

        @notification.save  
      end
    end
  end

  def update() 
    @notification = Notification.find(params[:id])
    
    @notification.update(read: params[:read])

    render plain: {success: true}
  end

  
end
