class PasswordResetsController < ApplicationController
	before_action :get_user,		only: [:edit, :update]
	before_action :valid_user,	only: [:edit, :update]
	before_action :check_expiration, only: [:edit, :update] # see #update case 1.
  def new
  end

  def create
  	@user = User.find_by(email:params[:password_reset][:email].downcase)
  	if @user
  		@user.create_reset_digest 				# from User controller
  		@user.send_password_reset_email		# also from there
  		flash[:info] = "Email sent with password reset instructions"
  		redirect_to root_url
  	else
  		flash.now[:danger] = "Email address not found"
  		render 'new'
  	end
  end

  def edit
  	@user = User.find_by(email:params[:email].downcase)
  end

  def update
  	# four cases:
  	# 1. expired password reset # dealt with a before filter at the top
  	# 2. failed update for invalid password
  	# 3. failed update for empty password or wrong confirmation)
  	# 4. SUCCESSFUL update
  	if params[:user][:password].empty?					# case 3.
  		@user.errors.add(:password, "can't be empty")
  		render 'edit'
  	elsif @user.update_attributes(user_params) 	# case 4.
  		log_in @user              # method below in the controller
      @user.update_attribute(:reset_digest, nil)
  		flash[:success] = "Password has been reset."
  		redirect_to @user
  	else
  		render 'edit'															# case 2.
  	end
  end

  private
		def user_params
  		params.require(:user).permit(:password, :password_confirmation)
  	end

  	# Before filters

  	def get_user
  		@user = User.find_by(email: params[:email])
  	end

  	# confirms a valid user
  	def valid_user 
  		unless (@user && @user.activated? && # ::authenticated from User model
  						@user.authenticated?(:reset, params[:id]))
  			redirect_to root_url		# to get the reset_digest
  		end
  	end

  	# checks expiration of reset token
  	def check_expiration
  		if @user.password_reset_expired? # in the User model
  			flash[:danger] = "Password reset has expired."
  			redirect_to new_password_reset_url
  		end
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