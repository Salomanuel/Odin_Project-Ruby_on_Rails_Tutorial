class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user and user.authenticate(params[:session][:password])
  		# log in and redirect
  	else
  		# error
  		flash[:danger] = "Invalid email/password"
  		render 'new'
  	end
  end

  def destroy
  end
end