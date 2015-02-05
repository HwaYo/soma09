class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def self.send_notification(post, send_user, message)
    self.all.each do |participant|
      next if participant.user == send_user
      Notification.create!({
        message: message,
        target_user: participant.user,
        send_user: send_user,
        post: post
      })
    end
  end

end