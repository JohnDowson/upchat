class MessagesController < ApplicationController
    before_action :set_user, only: %i[ create ]
    before_action :set_chat, only: %i[ create ]

    def create
        message = @chat.messages.create(content: params[:content], user_id: @user.id)

        message.broadcast_append_to "messages_#{@chat.id}", locals: { user: @user } if message
        head :ok
    end

    private
    def set_chat
        @chat = Chat.find(params[:chat_id])
    end

    def set_user
        @user = current_user
    end
end
