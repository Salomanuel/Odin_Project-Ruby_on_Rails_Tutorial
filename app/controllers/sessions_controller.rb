class SessionsController < ApplicationController
  def new
    # debugger
  end

  def create		# the first 'if user' is just to not make user.authenticate fail
    # user could be a @class variable for the sake of testing the way listing 9.27 does
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user and user.authenticate(params[:session][:password])
			log_in user 	   # methods in sessions_helper
			params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		flash[:success] = "logged in"
			redirect_back_or(user)	# (@user is used as the default argument of #redirect_back_or if there is no other path)
      # #redirect_back_or comes from sessions_helper
  	else
  		flash.now[:danger]  = "Invalid email/password combination"
			render 'new'
		end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_path
  end
end