require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
	def setup
		@user = users(:michael)
		# this code is WRONG
		@micropost = @user.microposts.build(content: "Lorem ipsum")
	end

	test "should be valid" do
		assert @micropost.valid?
	end

	test "user it should be present" do
		@micropost.user_id = nil
		assert_not @micropost.valid?
	end

	test "content should be present" do
		@micropost.content = "    "
		assert_not @micropost.valid?
	end

	test "content should not be too long" do
		@micropost.content = "a" * 141
		assert_not @micropost.valid?
	end

	test "order should be most recent first" do
		assert_equal microposts(:most_recent), Micropost.first
	end

	test "associated microposts should be destroyed" do
		@user.save
		@user.microposts.create!(content: "Lorem ipsum")
		assert_difference 'Micropost.count', -1 do
			@user.destroy
		end
	end
end
