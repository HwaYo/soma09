class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validate :validate_participants

  def self.send_notification(post, send_user, subject, text)
    @mailgun = Mailgun()

    self.all.each do |participant|
      next if participant.user == send_user
      Notification.create!({
        message: subject,
        target_user: participant.user,
        send_user: send_user,
        post: post
      })
      @mailgun.messages.send_email({
        to: participant.user.email,
        subject: subject,
        html: text,
        from: send_user.email
      })
    end
  end

  def validate_participants
    errors.add(:too_many_participant, "참여 인원을 초과하였습니다.") if self.post.participants.count >= self.post.max_participant_number
  end

end