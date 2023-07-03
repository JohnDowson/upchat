class ChatsController < ApplicationController
  before_action :set_chat, only: %i[ show edit update destroy ]

  # GET /chats or /chats.json
  def index
    @chats = Chat.all
  end

  # GET /chats/1 or /chats/1.json
  def show
    @other_user = @chat.users.where.not(id: current_user.id).first
  end

  def get_or_create
    @chat = (current_user.chats & User.find(params[:user_id]).chats).first
    if @chat
      redirect_to action: :show, id: @chat.id
    else
      params[:chat] = { users_id: params[:user_id] }
      create
    end
  end

  # GET /chats/new
  def new
    @chat = Chat.new
  end

  # GET /chats/1/edit
  def edit
  end

  # POST /chats or /chats.json
  def create
    new_params = { user_ids: [chat_params[:users_id], current_user.id] }

    @chat = Chat.new(new_params)

    if @chat.save
      redirect_to chat_url(@chat), notice: "Chat was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1 or /chats/1.json
  def update
    respond_to do |format|
      if @chat.update(chat_params)
        format.html { redirect_to chat_url(@chat), notice: "Chat was successfully updated." }
        format.json { render :show, status: :ok, location: @chat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chats/1 or /chats/1.json
  def destroy
    @chat.destroy

    respond_to do |format|
      format.html { redirect_to chats_url, notice: "Chat was successfully destroyed." }
      format.json { head :no_content }
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
