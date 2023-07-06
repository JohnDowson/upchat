require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:foo)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should show user" do
    sign_in @user
    get user_url(@user)
    assert_response :success
  end
end
