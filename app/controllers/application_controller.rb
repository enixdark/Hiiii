class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # before_filter :authenticate!
  
  include SessionsHelper
  include HomeHelper
  def authenticate!
  	if current_user.nil?
  		redirect_to user_login_url
  	end
  end



  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def menu
    @_menus =  get_menus
  end
end
