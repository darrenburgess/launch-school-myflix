def set_current_user(user=nil)
  user = user || Fabricate(:user)
  session[:user_id] = user.id
  user
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end
