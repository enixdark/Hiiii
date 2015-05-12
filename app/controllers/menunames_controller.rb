class MenunamesController < ApplicationController
  before_action :set_menuname, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate!, :menu
  # GET /menunames
  # GET /menunames.json
  def index
    @menunames = Menuname.all
  end

  # GET /menunames/1
  # GET /menunames/1.json
  def show
  end

  # GET /menunames/new
  def new
    @menuname = Menuname.new
  end

  # GET /menunames/1/edit
  def edit
  end

  # POST /menunames
  # POST /menunames.json
  def create
    # byebug
    @menuname = Menuname.new
    @menuname.name = menuname_params[:name]

    respond_to do |format|
      if @menuname.save
        format.html { redirect_to menus_index_path, notice: 'Menuname was successfully created.' }
        format.json { render :show, status: :created, location: @menuname }
      else
        format.html { render :new }
        format.json { render json: @menuname.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menunames/1
  # PATCH/PUT /menunames/1.json
  def update
    respond_to do |format|
      if @menuname.update(menuname_params)
        format.html { redirect_to menus_index_path, notice: 'Menuname was successfully updated.' }
        format.json { render :show, status: :ok, location: @menuname }
      else
        format.html { render :edit }
        format.json { render json: @menuname.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menunames/1
  # DELETE /menunames/1.json
  def destroy
    
    @menuname.destroy
    respond_to do |format|
      format.html { redirect_to menus_index_path, notice: 'Menuname was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menuname
      @menuname = Menuname.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menuname_params
      params[:menuname]
    end
end
