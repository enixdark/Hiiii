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


  #get user information based on session storage at browser
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  #get list menus from cache
  def menu
    @_menus =  get_menus
  end
end
