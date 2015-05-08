class PasswordResetsController < ApplicationController
  layout 'layouts/sessionbase'

  before_filter :get_user, only: [:edit, :update]
  before_filter :valid_user, only: [:edit, :update]


  def new
  end

  def create

  	# byebug
  	if @user = User.find_by(email: params[:password_reset][:email].downcase)

  	  @user.create_reset_digest
  	  @user.send_password_reset_email
  	  redirect_to root_url, notice: "Email sent with password reset instructions"
  	else
  	  render 'new', notice: "Email address not found"
  	end

  end

  def update
  	
  end

  def edit
  end

  private
    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      # unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      # 	redirect_to root_url
      # end
      unless (@user && @user.authenticated?(:reset, params[:id]))
      	redirect_to root_url
      end
    end
end
