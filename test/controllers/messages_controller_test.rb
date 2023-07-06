require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "creating message broadcasts it to chat members" do
    chat = chats(:one)
    assert_broadcasts "messages_#{chat.id}", 1 do
      sign_in users(:foo)
      post messages_url(chat_id: chat.id), params: { content: "Test message" }
      assert_response :success
    end
  end
end
