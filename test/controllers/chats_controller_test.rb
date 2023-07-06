require "test_helper"

class ChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chat = chats(:one)
  end

  test "should show chat" do
    sign_in users(:foo)
    get chat_url(@chat)
    assert_response :success
  end

  test "creates chat with user when there isn't one" do
    sign_in users(:foo)
    bar = users(:bar)
    Chat.destroy_all
    assert_changes "Chat.count", from: 0, to: 1 do
      get user_chat_url(user_id: bar.id)
      id = Chat.first.id
      assert_redirected_to chat_url(id:)
    end
  end

  test "finds chat with user when there is one" do
    sign_in users(:foo)
    bar = users(:bar)
    chat = chats(:one)
    get user_chat_url(user_id: bar.id)
    assert_redirected_to chat_url(id: chat.id)
  end
end
