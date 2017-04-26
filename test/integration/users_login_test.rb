require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end

	test "login with invalid information" do
		# visit the login path
		get login_path
		# verify that the new sessions form renders properly
		assert_template 'sessions/new'	
		# post to the sessions path with an invalid params hash
		post login_path, params: { session: { email:"", password:"" } }
		# verify that the new session form gets re-rendered
		assert_template 'sessions/new'
		# and that a flash message appears
		assert_not flash.empty?
		# visit another page (home)
		get root_path
		# verify that the flash is not present
		assert flash.empty?
	end

	test "login with valid information" do
		get login_path
		post login_path, params: { session: { email: 		@user.email,
																					password: 'password' } }
		# gets redirected to the user page
		assert_redirected_to @user
		# actually visit the target page
		follow_redirect!
		assert_template 'users/show'
		# there are ZERO login paths on the page
		assert_select "a[href=?]", login_path, count: 0
		assert_select "a[href=?]", logout_path
		assert_select "a[href=?]", user_path(@user)
	end
end