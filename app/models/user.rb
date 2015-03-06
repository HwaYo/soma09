class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :comments, dependent: :destroy

  has_one :notification_target, :class_name => 'Notification', :foreign_key => 'send_user_id', dependent: :destroy
  has_many :notifications, :class_name => 'Notification', :foreign_key => 'target_user_id', dependent: :destroy

  has_many :posts
  has_many :participants
  has_many :posts, through: :participants

  def approve!
    update!(approved: true)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.url = auth.info.urls['Facebook']
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
