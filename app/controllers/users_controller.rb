class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate!, :menu


  # GET /users
  # GET /users.json
  def index
    if request.get?
      @users = User.paginate(:page => params[:page], :per_page => 2)
    elsif request.post?
      # byebug
      @users = User.where(nil)
      filter_params.each do |key, value|
        @users = @users.public_send(key, value) if value.present?
      end

      @users = @users.paginate(:page => params[:page], :per_page => 2)
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    # byebug
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # @user.send_activation_email
        format.html { redirect_to users_view_path(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # byebug
    respond_to do |format|
      path = request.path
      if path.include? 'password' 
        _params = pass_params
        _next = profile_password_path
        _render = 'home/user/password'
        notice = 'Password was successfully updated.'
      else 
        _params = user_params
        if path.include? 'profile'
          # _params = _params.permit(:name, :username, :email)
          _next = profile_path
          _render = "home/user/profile"
          notice = 'User was successfully updated.'
        else
          _next = users_view_path(@user)
          notice = 'User was successfully updated.'
          _render = :edit
        end
      end

      if @user.update(_params)
        format.html { redirect_to _next, notice: notice }
        # format.json { render :show, status: :ok, location: @user }
      else
        format.html { render _render }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_index_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def profile
    render 'home/user/password'
  end

  def user_view user
    render 'show'
  end

  private

    #assign user based on id when use post/put method  
    def set_user
      # byebug
      if (params.has_key? :user) && (not params[:user][:id].nil?)
        @user = User.find(params[:user][:id])
      elsif not params[:id].nil?
        @user = User.find(params[:id])
      end
    end


    def filter_params

      params.require(:user_search).slice(:start_name, :start_username, 
        :start_email, :start_role, :start_level)
    end

    def pass_params
      params.require(:user).permit(:password, :new_password, :password_confirmation)
    end

    def user_params
      params.require(:user).permit(:name, :username, :email, :role, :password)
    end
end
