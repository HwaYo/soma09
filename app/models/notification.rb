class Notification < ActiveRecord::Base
  belongs_to :post
  belongs_to :target_user, :class_name => 'User'
  belongs_to :send_user, :class_name => 'User'
end
