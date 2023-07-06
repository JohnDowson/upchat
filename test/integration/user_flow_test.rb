require "test_helper"

class UserFlowTest < ActionDispatch::IntegrationTest
  test "prompted for login" do
    get root_url
    follow_redirect!
    assert_select "h2", "Log in"
  end

  test "redirected to user page after login" do
    user = users(:foo)
    sign_in user
    get root_url
    follow_redirect!
    assert_equal "/users/#{user.id}", path
  end

  test "can start new chat" do
    Chat.destroy_all

    user = users(:foo)
    sign_in user
    get users_url
    assert_select "a", "Upchat 'em up"
    get user_chat_url(users(:bar))
    follow_redirect!
    assert_equal "/chats/#{Chat.first.id}", path
  end
end
