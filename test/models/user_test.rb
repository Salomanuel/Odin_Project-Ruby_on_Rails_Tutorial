require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "Gianni", 
							email:"gianni@gianni.gia", 
							password: "gianni",
							password_confirmation: "gianni")
	end

	test "it should work" do
		assert @user.valid?
	end
end