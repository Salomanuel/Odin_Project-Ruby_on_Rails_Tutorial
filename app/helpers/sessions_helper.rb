module SessionsHelper
	
	# logs in the given user
	def log_in(user)
		session[:user_id] = user.id			# sessions is a temporary cookie
	end

	# returns the current logged-in user (if any)
	# def current_user
	# 	@current_user ||= User.find_by(id: session[:user_id])
	# end

	# returns true if the given user is the current user
	def current_user?(user)
		user == current_user
	end	

	# returns the user corresponding to the remember token cookie
	def current_user
		if 		(user_id = session[:user_id]) 				# does it exist?
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])  # is there a persisten session?
			# raise # the tests still pass, so this branch is currently untested
			user = User.find_by(id: user_id) 							# .authenticated comes from models/user
			# if user and user.authenticated?(cookies[:remember_token])
			# updated this line for the new authenticated method
			if user && user.authenticated?(:remember, cookies[:remember_token])
				# 	( def authenticated?(attribute, token) from User model)
				#            so it will be remember_digest
				log_in user								# from this same file
				@current_user = user
			end
		end
	end

	# returns true if the user is logged in
	def logged_in?
		!current_user.nil?
	end

	# forgets a persistent session
	def forget(user)
		user.forget 										# from models/user
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# logs out the current user
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	# remembers a user in a persisten session
	def remember(user)
		user.remember										# from models/user
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end																# from an attr_accessor of models/user

	# redirects to stored location (or the default), after it, it cleans itself
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default )
		session.delete(:forwarding_url)
	end

	# stores the URL trying to be accessed
	def store_location											#  but only for a GET request
		session[:forwarding_url] = request.original_url if request.get?
	end # puts the requested URL in the session variable under the key :forwarding_url
end