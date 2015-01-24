class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.all
  end

  def approve
    user = User.find(params[:id])
    user.approve!

    redirect_to [:admin, :users]
  end
end
