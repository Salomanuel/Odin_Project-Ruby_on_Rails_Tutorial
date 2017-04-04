class UsersController < ApplicationController
  def new
  	# debugger
  end

  def show
  	@user = User.find(params[:id])
  	# debugger
  end

  def index
  	@users = User.all
  end
end
