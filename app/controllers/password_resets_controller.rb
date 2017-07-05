class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(email:params[:password_reset][:email].downcase)
  	if @user
  		@user.create_reset_digest
  		@user.send_password_reset_email
  		flash[:info] = "Email sent with password reset instructions"
  		redirect_to root_url
  	else
  		flash.now[:danger] = "Email address not found"
  		render 'new'
  	end
  end

  def edit
  end
end

=begin
upon submitting
1) find user by email
2) update its attributes with 
	- the password reset token
	- sent_at timestamp
3) redirect to root_url
4) flash message

in case of an invalid submission,
	the form will be re-rendered with a flash.now message
=end 