class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user and user.authenticate(params[:session][:password])
  		# log user in
  	else
  		# create and error message
  		flash.now[:danger] = "invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  end
end
