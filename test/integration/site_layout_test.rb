require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
	def setup
		@user       = users(:michael)
		@other_user = users(:archer)
	end

	test "layout links while NOT logged in" do
		get root_path
			assert_template 'static_pages/home'
			assert_select "a[href=?]", root_path, 				count: 2
			assert_select "a[href=?]", help_path
			assert_select "a[href=?]", about_path
			assert_select "a[href=?]", contact_path
		get contact_path
			assert_template 'static_pages/contact'
			assert_select "title", full_title("Contact")
		get signup_path
			assert_template 'users/new'
			assert_select "title", full_title("Sign up")
		get help_path
			assert_template 'static_pages/help'
		get login_path
			assert_template 'sessions/new'
		# REDIRECTS BECAUSE NOT LOGGED IN
			assert_select "a[href=?]", logout_path, 			count: 0
		get users_path
			assert_redirected_to login_path
		get edit_user_path(@user)
			assert_select "a[href=?]", user_path(@user), 	count: 0
			assert_redirected_to login_path
	end	

	test "layout links while logged in" do
		log_in_as(@user)
		get root_path
			assert_template 'static_pages/home'
			assert_select "a[href=?]", root_path, 				count: 2
			assert_select "a[href=?]", help_path
			assert_select "a[href=?]", about_path
			assert_select "a[href=?]", contact_path
		get contact_path
			assert_template 'static_pages/contact'
			assert_select "title", full_title("Contact")
		get signup_path
			assert_template 'users/new'
			assert_select "title", full_title("Sign up")
		get help_path
			assert_template 'static_pages/help'
		get login_path
			assert_template 'sessions/new'
		# LOGGED IN SPECIFIC URLS
			assert_select "a[href=?]", logout_path
		get users_path
			assert_template 'users/index'
		get edit_user_path(@user)
			assert_select "a[href=?]", user_path(@user)
		end
end
