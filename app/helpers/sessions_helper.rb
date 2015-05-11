module SessionsHelper

  def log_in user
    user.generate
  	session[:user_id] = user.id
  end

  

  def logged_in?
  	!current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
  	forget(current_user)
  	session.delete(:user_id)
  	@current_user = nil
  end

  def authenticate!
  	if current_user.nil?
  	  redirect_to user_login_url
  	end
  end

  def current_user
  	if session[:user_id]
  	  @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  	elsif cookies.signed[:user_id]
  	  user = User.find_by(id: cookies.signed[:user_id])
  	  if user && user.authenticate?(cookies[:remember_token])
  	  	log_in user
  	  	@current_user = user
  	  end
  	end
  end

  def remember_token user
  	user.remember
  	cookies.permanent.signed[:user_id] = user.id
  	cookies.permanent[:remember_token] = user.remember_token
  end


end
