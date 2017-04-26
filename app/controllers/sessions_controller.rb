class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user and user.authenticate(params[:session][:password])
			# log in and redirect to the user's show page
			log_in user
			redirect_to user
		else
			# create an error message
			flash.now[:danger] = "invalid user/email combination"
			render 'new'
		end
	end

	def destroy
		log_out
		redirect_to root_url
	end

end