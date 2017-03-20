require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_url
    assert_response :success
  end

  setup do
    @title_long = "| Ruby on Rails Tutorial Sample App"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Home #{@title_long}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help #{@title_long}"
  end

  test "should get about" do
  	get about_path
  	assert_response :success
    assert_select "title", "About #{@title_long}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact #{@title_long}"
  end
end
