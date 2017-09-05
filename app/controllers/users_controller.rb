class UsersController < ApplicationController
  before_action :require_logged_out, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Your account was created"
      redirect_to signin_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password, :password_confirmation)
  end
end
