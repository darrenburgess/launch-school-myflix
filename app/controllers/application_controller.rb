class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :logged_out?, :require_user, :require_logged_out, :access_denied

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def logged_out?
    !logged_in?
  end

  def require_user
    access_denied if logged_out?
  end

  def require_logged_out
    access_denied if logged_in? 
  end

  def access_denied
    if logged_out?
      flash[:error] = "You must be logged in to do that"
      redirect_to signin_path
    else
      flash[:error] = "You must be logged out to do that"
      redirect_to home_path
    end
  end
end
