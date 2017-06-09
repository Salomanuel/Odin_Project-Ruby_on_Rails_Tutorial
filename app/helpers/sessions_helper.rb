module SessionsHelper
	
	# logs in the given user
	def log_in(user)
		session[:user_id] = user.id
	end

	# returns the current logged-in user (if any)
	# def current_user
	# end

	# returns the user corresponding to the remember token cookie
	def current_user
		if 		(user_id = session[:user_id]) # does it exist?
			return User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])  # is there a persisten session?
			user = User.find_by(id: user_id) 
			if user and user.authenticated?(cookies[:remember_token])
				log_in user
				return user
			end
		end
	end

	# returns true if the user is logged in
	def logged_in?
		!current_user.nil?
	end

	# forgets a persistent session
	def forget(user)
		user.forget # from models/user.rb
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	# logs out the current user
	def log_out
		forget(current_user)
		session.delete(:user_id)
	end

	# remembers a user in a persisten session
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end
end
