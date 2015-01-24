class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

protected
  def authenticate_user!
    super

    if current_user and !current_user.approved?
      sign_out current_user
      redirect_to [:user, :session], notice: "아직 승인되지 않았습니다."
    end
  end
end
