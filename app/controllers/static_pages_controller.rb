class StaticPagesController < ApplicationController
  def home
  	# @micropost = Micropost.new
  	@micropost = current_user.microposts.build if logged_in?
  	@user = current_user
  end

  def help
  end

  def about
  end

  def contact
  end
  
end