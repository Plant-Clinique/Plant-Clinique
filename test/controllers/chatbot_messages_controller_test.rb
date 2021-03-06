require "test_helper"

class ChatbotMessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chatbot_message = chatbot_messages(:one)
  end

  test "should get index" do
    get chatbot_messages_url
    assert_response :success
  end

  test "should get new" do
    get new_chatbot_message_url
    assert_response :success
  end

  test "should create chatbot_message" do
    assert_difference('ChatbotMessage.count') do
      post chatbot_messages_url, params: { chatbot_message: { content: @chatbot_message.content, from_bot: @chatbot_message.from_bot, time_sent: @chatbot_message.time_sent, user_id: @chatbot_message.user_id } }
    end

    assert_redirected_to chatbot_message_url(ChatbotMessage.last)
  end

  test "should show chatbot_message" do
    get chatbot_message_url(@chatbot_message)
    assert_response :success
  end

  test "should get edit" do
    get edit_chatbot_message_url(@chatbot_message)
    assert_response :success
  end

  test "should update chatbot_message" do
    patch chatbot_message_url(@chatbot_message), params: { chatbot_message: { content: @chatbot_message.content, from_bot: @chatbot_message.from_bot, time_sent: @chatbot_message.time_sent, user_id: @chatbot_message.user_id } }
    assert_redirected_to chatbot_message_url(@chatbot_message)
  end

  test "should destroy chatbot_message" do
    assert_difference('ChatbotMessage.count', -1) do
      delete chatbot_message_url(@chatbot_message)
    end

    assert_redirected_to chatbot_messages_url
  end
end
