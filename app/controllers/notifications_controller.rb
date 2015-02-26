class NotificationsController < ApplicationController
  def update() 
    @notification = Notification.find(params[:id])
    
    @notification.update(read: params[:read])

    render plain: {success: true}
  end
end
