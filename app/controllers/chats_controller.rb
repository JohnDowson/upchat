class ChatsController < ApplicationController
  before_action :authenticate_user!, only: %i[ create get_or_create show ]
  before_action :set_chat, only: %i[ show ]

  # GET /chats or /chats.json
  def index
    @chats = Chat.all
  end

  # GET /chats/1 or /chats/1.json
  def show
    @other_user = @chat.users.where.not(id: current_user.id).first
    @messages = @chat.messages.preload(:user)
  end

  def get_or_create
    @chat = (current_user.chats & User.find(params[:user_id]).chats).first
    if @chat
      redirect_to chat_path(@chat)
    else
      params[:chat] = { users_id: params[:user_id] }
      create
    end
  end

  # POST /chats
  def create
    new_params = { user_ids: [chat_params[:users_id], current_user.id] }

    @chat = Chat.new(new_params)

    if @chat.save
      redirect_to chat_path(@chat), notice: "Chat was successfully created."
    else
      redirect_to "/users", notice: "Error when creating chat: #{@chat.errors.full_messages.join}"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:users_id, :user_id)
    end
end
