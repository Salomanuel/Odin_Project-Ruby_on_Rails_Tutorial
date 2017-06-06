class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user and user.authenticate(params[:session][:password])
  		# log in and redirect to user show
  		flash[:success] = "logged in"
  		render 'new'
  		# render html: "login"
  	else
  		flash[:danger]  = "Invalid email/password combination"
  		# error message
			render 'new'
			# render html: "error"
		end
  end

  def destroy
  end
end