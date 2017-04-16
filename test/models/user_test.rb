require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "Gianni", 
							email:"gianni@gianni.gia", 
							password: "giannigianni",
							password_confirmation: "giannigianni")
	end

	test "it should work" do
		assert @user.valid?
	end

	test "it should have a name" do
		@user.name = "   "
		assert_not @user.valid?
	end

	test "user name shouldn't be too long" do
		@user.name = "a" * 40
		assert_not @user.valid?
	end

	test "it should have an email" do
		@user.email = "    "
		assert_not @user.valid?
	end

	test "email shouldn't be too long" do
		@user.email = "a" * 40
		assert_not @user.valid?
	end

	test "email addresses should be valid" do
		valid_addresses = [	"user@example.com", 		"USER@foo.COM", 
												"A_US-ER@foo.bar.org", 	"first.last@foo.jp", 
												"alice+bob@baz.cn"]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test "email should be unique" do
		duplicate_user = @user.dup
		@user.save
		assert_not duplicate_user.valid?
	end

	test "password should be present" do
		@user.password = @user.password_confirmation = " " * 6
		assert_not @user.valid?
	end

	test "password shouldn't be too short" do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end
end