class HomeController < ApplicationController

	before_filter :authenticate!, :menu
	

	def index
	end

	def update(_params, template)
      notice = nil
	  if request.put?
	  	begin
	  	  if block_given?
	  	  	Proc.new.call
	  	  else
	  	    @current_user.update_attributes(_params)
	  	  end
	      notice = "user update success"
	  	rescue Error => e
	  	  notice = e.message
	  	end
	  end
	  render template, notice: notice
	end

	def profile
	  self.update(home_params,'home/user/profile')
	end

	def profile_password

	  self.update(pass_params,'home/user/password') do 
	  	if pass_params[:new_password] != pass_params[:password_confirmation]
	  	  notice = "password don't match"
	  	else
	  	  # byebug
	  	  @current_user.password = pass_params[:new_password]
	  	  if @current_user.valid?
	  		@current_user.save
	  		log_in @current_user, bypass: true
	  	  end
	  	end
	  end

	end

	protected

      def home_params
      	if params.has_key?(:user)
      	  params.require(:user).permit(:username, :email, :name)
      	end
      end

      def pass_params
      	if params.has_key?(:user)
      	  params.require(:user).permit(:password,:new_password,:password_confirmation)
      	end
      end
end
