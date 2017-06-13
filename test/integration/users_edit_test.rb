require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end

	test "unsuccessful edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		name  = ""
		email = ""
		patch user_path(@user), params:
			{user: { name:  name,
							 email: email}}
		assert_template 'users/edit'
		assert_select "div.alert", "The form contains 3 errors."
	  assert_not_equal name,  @user.name
	  assert_not_equal email, @user.email

	end

	test "successful edit" do
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		name  = "Foo Bar"
		email = "foo@bar.baz"
		patch user_path(@user), params: 
		{ user: { name: 	name, 
							email: 	email }}
		assert_not flash.empty?
		assert_redirected_to @user
		@user.reload
		assert_equal name, 	@user.name
		assert_equal email, @user.email
	end
end