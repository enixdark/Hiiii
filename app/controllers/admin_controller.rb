class AdminController < ApplicationController
  before_filter :authenticate!, :menu

end
