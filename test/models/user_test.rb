require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "Example User", email: "user@example.ex")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.name = "   "
		assert_not @user.valid?
	end

	test "name shoult not be longer than 50" do
		@user.name = "a" * 52
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = "    "
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "a" * 244 + "@example.com"
		assert_not @user.valid?
	end

	test "valid email should pass" do
		valid_addresses = ["user@example.org",
											 "USER@foo.COM", "A_US-ER@foo.bar.org",
											 "first.last@foo.jp", "alice+bob@baz.cn"]
		valid_addresses.each do |mail|
			@user.email = mail
			assert@user.valid?, "#{mail.inspect} should be valid"
		end
	end
    
	test "not valid emails shalt not pass" do
		invalid_addresses = ["user@example,com", "user_at_foo.org",
												 "user.name@example.",
												 "foo@bar_baz.com", "foo@bar+baz.com"]
		invalid_addresses.each do |mail|
			@user.email = mail
			assert_not @user.valid?, "#{mail.inspect} should be invalid"
		end
	end

	test "email addresses should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end
end
