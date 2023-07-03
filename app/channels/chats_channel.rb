class ChatsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages_#{params[:chat_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
