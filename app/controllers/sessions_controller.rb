class SessionsController < ApplicationController
  layout 'layouts/sessionbase'

  def new
  	render 'new'
  end

  def create
    # user = User.where('email = :value or username= :value',{ value: session_params[:signin]}).first
    if user = User.authenticate(session_params[:signin],session_params[:password])
      log_in user
      # byebug
      redirect_to root_path
    else
      # flash[:danger] = 'Invalid email/password combination'
      render 'new', danger: 'Invalid email/password combination'
    end
  end

  def destroy
  	log_out
  	redirect_to root_path
  end

  protected
  	def session_params
  		params.require(:session).permit(:signin,:password)
  	end
end
