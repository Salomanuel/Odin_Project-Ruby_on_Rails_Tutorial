require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	test "login with INVALID information" do
		# visit the login path
		get login_path
		# verify that the new sessions form render properly
		assert_template 'sessions/new'
		# post to sessions path with an invalid params hash
		post login_path, params: { session: { email:"", password:"" } }
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