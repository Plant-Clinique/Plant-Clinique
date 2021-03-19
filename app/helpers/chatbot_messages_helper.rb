module ChatbotMessagesHelper
  def reply_to_user_message(user_message_content)
    processed_user_message_content = user_message_content.downcase

    if processed_user_message_content == "hello"
      "hi!"
    elsif processed_user_message_content == "how are you"
      "good!"
    elsif processed_user_message_content == "what do you know"
      "EVERYTHING"
    elsif processed_user_message_content == "what is your name"
      "my name is plant bot... for now"
    else
      "what do you mean by #{processed_user_message_content}?"
    end
  end

  def create_options(chatbot_message)
    if chatbot_message
      chatbot_message = chatbot_message["content"]
    else
      chatbot_message = "none"
    end
    if chatbot_message == "EVERYTHING"
      ["wow", "cool", "awesome"]
    elsif chatbot_message == "none"
      ["I have a question", "I'm just checking in"]
    else
      ["option 1", "option 2"]
    end
  end
end
