require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael) # from fixture
	end

	test "login with VALID information" do
		skip
		# visit the login path
		get login_path
		# post valid information to the sessions path
		post login_path, params: { session: {  email: @user.email, 
																				password: 'password' } }
		# verify the redirection to the user page
		assert_redirected_to @user
		# actually follow that redirection
		follow_redirect!
		# verify that the user page is loaded
		assert_template 'users/show'
		# verify that the login link disappears (0 present)
		assert_select "a[href=?]", login_path, count: 0
		# verify that a logout link appears
		assert_select "a[href=?]", logout_path
		# verify that a profile link appears
		assert_select "a[href=?]", user_path(@user)
	end

	test "login with INVALID information" do
		# skip
		# visit the login path
		get login_path
		# verify that the new sessions form render properly
		assert_template 'sessions/new'
		# post to sessions path with an invalid params hash
		post login_path, params: { session: {  email: "", 
																				password: "" } }
		# verify that the new sessions form gets re-rendered
		assert_template 'sessions/new'
		# verify that a flash message appears
		assert_not flash.empty?
		# visit another page (root)
		get root_path
		# verify that the flash message DOESN'T appear
		assert flash.empty?
	end
end