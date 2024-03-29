class ChatbotMessagesController < ApplicationController
  before_action :require_login
  before_action :set_chatbot_message, only: %i[ show edit update destroy ]




  # GET /chatbot_messages or /chatbot_messages.json
  def index
    @chatbot_messages = ChatbotMessage.all
  end

  # GET /chatbot_messages/1 or /chatbot_messages/1.json
  def show
  end

  # GET /chatbot_messages/new
  def new
    @chatbot_message = ChatbotMessage.new
  end

  # GET /chatbot_messages/1/edit
  def edit
  end

  # POST /chatbot_messages or /chatbot_messages.json
  def create
    @chatbot_message = ChatbotMessage.create(chatbot_message_params)

    ChatbotMessage.create(user_id: chatbot_message_params['user_id'],
                          time_sent: Time.now.utc,
                          from_bot: true,
                          content: helpers.reply_to_user_message(chatbot_message_params['content']))

    redirect_to chatbot_messages_url
  end

  # PATCH/PUT /chatbot_messages/1 or /chatbot_messages/1.json
  def update
    respond_to do |format|
      if @chatbot_message.update(chatbot_message_params)
        format.html { redirect_to @chatbot_message, notice: "Chatbot message was successfully updated." }
        format.json { render :show, status: :ok, location: @chatbot_message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chatbot_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chatbot_messages/1 or /chatbot_messages/1.json
  def destroy
    @chatbot_message.destroy
    respond_to do |format|
      format.html { redirect_to chatbot_messages_url, notice: "Chatbot message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatbot_message
      @chatbot_message = ChatbotMessage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chatbot_message_params
      params.permit(:user_id, :time_sent, :from_bot, :content)
    end
end
