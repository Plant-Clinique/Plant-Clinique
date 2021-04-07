require "test_helper"

class ChatbotMessageTest < ActiveSupport::TestCase
  def setup
    User.create!(username: "one", email: "two@one.com", password:"three")
    @chatbot_user_message= ChatbotMessage.new(user_id: User.first.id, time_sent:Time.now, from_bot:false, content:"hi bot")
    @chatbot_bot_message= ChatbotMessage.new(user_id: User.first.id, time_sent:Time.now, from_bot:true, content:"hi human")
  end
  test "chatbot user message should be valid" do
    assert @chatbot_user_message.valid?
  end
  test "chatbot bot message should be valid" do
    assert @chatbot_bot_message.valid?
  end
  test "user message content should be present" do
    @chatbot_user_message.content = "     "
    assert_not @chatbot_user_message.valid?
  end
  test "bot message content should be present" do
    @chatbot_bot_message.content = "     "
    assert_not @chatbot_bot_message.valid?
  end
end
