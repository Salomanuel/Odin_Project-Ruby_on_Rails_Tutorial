class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index     # 1
    # @users = User.paginate(page: params[:page])
    # only show activated users in the list
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show      # 2
  	@user = User.find(params[:id])
    # skip page if user is not activated
    redirect_to root_url and return unless @user.activated
  	# debugger
  end

  def new       # 3
		@user = User.new
  end

  def create    # 4
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_email # in the User mode
      # UserMailer.account_activation(@user).deliver_now 
      flash[:info]    = "Please check your email to activate your account."
      redirect_to root_url
  		# log_in @user
  		# flash[:success] = "Welcome to the Sample App!"
  		# redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit      # 5
  end

  def update    # 6
    if @user.update_attributes(user_params)
      flash[:success] = "User successfully updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy  # 7  # add the corresponding before_actionS as well
    User.find(params[:id]).destroy  # #destroy from Active record
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
  	def user_params
  		params.require(:user).permit(	
  			:name,  			:email, 
  			:password,		:password_confirmation)
  	end
  	
    # before filters

    # confirms a logged-in user
      # used in the filter before_action
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end

    #confirms the correct user
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
      # current_user in session_helper, returns the user corresponding to the remember token cookie

    # confirms an admin user
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end