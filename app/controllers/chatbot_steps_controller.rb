class ChatbotStepsController < ApplicationController
  before_action :require_login
  include Wicked::Wizard

  steps :choose_visit_type, :choose_plant, :select_symptoms, :answer_symptoms_questions, :display_possible_treatments # MORE STEPS GO HERE!

  def show
    @user = current_user
    
    case step
    when :choose_visit_type
      @bot_message = ChatbotMessage.create(user_id: current_user.id,
                                          time_sent: Time.now.utc,
                                          from_bot: true,
                                          content: "hello user!")
      @chatbot_message = ChatbotMessage.new
      @text = "Yo yo yo choose visit type"
    when :choose_plant
      @text = "Nice, time to choose a plant"
    end
    render_wizard
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    render_wizard @user
  end

  def new
    @chatbot_message = ChatbotMessage.new
  end
end
