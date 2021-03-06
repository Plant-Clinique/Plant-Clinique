json.extract! chatbot_message, :id, :user_id, :time_sent, :from_bot, :content, :created_at, :updated_at
json.url chatbot_message_url(chatbot_message, format: :json)
