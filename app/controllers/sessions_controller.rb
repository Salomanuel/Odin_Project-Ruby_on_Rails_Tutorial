class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user and user.authenticate(params[:session][:password])
			log_in user 	# method in sessions_helper
			remember user # method in sessions_helper
  		flash[:success] = "logged in"
			redirect_to user	
  	else
  		flash.now[:danger]  = "Invalid email/password combination"
			render 'new'
		end
  end

  def destroy
  	log_out
  	redirect_to root_path
  end
end