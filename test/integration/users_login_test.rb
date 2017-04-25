require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
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
end