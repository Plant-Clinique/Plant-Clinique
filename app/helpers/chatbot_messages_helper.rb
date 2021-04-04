require 'net/http'
require 'json'

module ChatbotMessagesHelper
  @@commands = { 'hi'=> 'hello',
                'i have a question'=> 'Which of your plants is it about?',
                "i'm just checking in"=> 'Cool, choose a plant you want to check in',
                'restart'=> 'Restart'}

  def reply_to_user_message(user_message_content)
    if not UserPlant.where(user_id: current_user.id, name: user_message_content).empty?
      plant = UserPlant.where(user_id: current_user.id, name: user_message_content).first
      result = JSON.parse(Net::HTTP.get(URI.parse("https://trefle.io/api/v1/plants/search?token=6j4O7U0FSKM_Te6mN3aFN7TORBk0RYtU_wk5sJgkjbw&q=#{plant.plant_type.parameterize.underscore}")))
      "#{plant.name} is a #{plant.plant_type} and its scientific name is #{result["data"][0]["scientific_name"].titleize}"
    elsif user_message_content.downcase == 'restart'
      ChatbotMessage.where(user_id: current_user.id).delete_all
      "Restarted"
    else
      @@commands.fetch(user_message_content.downcase, "what do you mean by #{user_message_content.downcase}")
    end
  end

  def create_options(chatbot_message)
    if chatbot_message
      chatbot_message_content = chatbot_message["content"]  
      if chatbot_message_content.include? "what do you mean by"
        ["Restart"]
      elsif (chatbot_message_content == @@commands['i have a question'] ||
            chatbot_message_content == @@commands["i'm just checking in"]) &&
            !UserPlant.where(user_id: current_user.id).empty?
        result = ["Restart"] 
        result << UserPlant.where(user_id: current_user.id).map(&:name)
        result
      elsif chatbot_message_content == @@commands['restart']
        ["I have a question", "I'm just checking in", "Restart"]
      else
        ["I have a question", "I'm just checking in", "Restart"]
      end
    else
      ["I have a question", "I'm just checking in", "Restart"]
    end
  end
end
