class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user and user.authenticate(params[:session][:password])
  		# log in and redirect to user show
  		flash.now[:success] = "logged in"
  		render 'new'
  	else
  		flash.now[:danger]  = "Invalid email/password combination"
			render 'new'
		end
  end

  def destroy
  end
end