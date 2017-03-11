require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @title_long = "| Ruby on Rails Tutorial Sample App"
  end

  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "Home #{@title_long}"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "Help #{@title_long}"
  end

  test "should get about" do
  	get static_pages_about_url
  	assert_response :success
    assert_select "title", "About #{@title_long}"
  end

end
