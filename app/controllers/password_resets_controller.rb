class PasswordResetsController < ApplicationController
  layout 'layouts/sessionbase'

  before_filter :get_user, only: [:edit, :update]
  before_filter :valid_user, only: [:edit, :update]
  before_filter :check_expiration, only: [:edit, :update]

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
  	if user_params[:password].blank?
  	  render 'edit', notice: 'Password cannot blank'
  	elsif @user.update_attributes(user_params)
  	  log_in @user
  	  redirect_to root_url
  	else
      render 'new', notice: "Email address not found"
    end
  end

  def edit
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

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

    def check_expiration
      if @user.password_reset_expired?
        redirect_to new_password_reset_url, notice: "Password reset has expired."
      end
    end
end
