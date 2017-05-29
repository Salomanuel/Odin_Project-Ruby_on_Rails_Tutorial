class StaticPagesController < ApplicationController
  def home
  	# @base_title = 
		@title       = "Home"
  end

  def help
  	@title = "Help"
  end

  def about
  	@title = "About"
  end

  def base_title
  	@base_title = "| Ruby on Rails Tutorial Sample App"
  end
end
