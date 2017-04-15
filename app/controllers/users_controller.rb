class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	# debugger
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		#ok
  	else
  		render 'new'
  	end
  end
end
