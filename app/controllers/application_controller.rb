class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def hello
  	render html: "hello, world!"
  end

  private
  	# confirms a logged_in user
    # used in the filter before_action
  	# it was in the Users controller, but it's 
  	# needed by the Microposts as well
  	def logged_in_user
  		unless logged_in?
  			store_location
  			flash[:danger] = "Please log in."
  			redirect_to login_url
  		end
  	end
end
