class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])

    if @user.authenticate(params[:password])
      flash[:notice] = "Welcome, #{@user.full_name}"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy 
    flash[:notice] = "You are logged out" 
    session[:user_id] = nil
    redirect_to root_path
  end
end
