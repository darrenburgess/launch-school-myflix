class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome, #{user.full_name}"
      redirect_to home_path
    else
      flash.now[:error] = "Invalid email or password"
      render :new
    end
  end

  def destroy 
    flash[:notice] = "You are logged out" 
    session[:user_id] = nil
    redirect_to root_path
  end
end
