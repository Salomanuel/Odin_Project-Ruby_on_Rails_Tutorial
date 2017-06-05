class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  	# debugger
  end

  def new
		@user = User.new
  end

  def create
  	@user = User.new(params[:user]) # not final
  	if @user.save
  		render html: "user saved"
  	else
  		render 'new'
  	end
  end

  
end