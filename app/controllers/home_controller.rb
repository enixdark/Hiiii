class HomeController < ApplicationController

	before_filter :authenticate!, :menu
	include HomeHelper
	def index
	end

	protected
	  def menu
       @menus =  get_menus
      end
end
