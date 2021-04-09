class ChatbotStepsController < ApplicationController
  before_action :require_login
  include Wicked::Wizard

  steps :choose_visit_type, :choose_plant, :select_symptoms, :answer_symptoms_questions, :display_possible_treatments # MORE STEPS GO HERE!

  def show
    @user = current_user
    @plant = "none"
    case step
    when :choose_visit_type
      # @bot_message = ChatbotMessage.create(user_id: current_user.id,
      #                                     time_sent: Time.now.utc,
      #                                     from_bot: true,
      #                                     content: "hello user!")
      # @chatbot_message = ChatbotMessage.new
    when :choose_plant
      @user_plants = UserPlant.where(user_id: current_user.id)
    when :select_symptoms
    end
    render_wizard
  end

  def update
    @user = current_user
    @user_plants = UserPlant.where(user_id: current_user.id)
    case step
    when :choose_plant
      @plant =UserPlant.where(user_id: current_user.id, id: params[:plant_id].to_i).first.name
    when :select_symptoms
      @plant =UserPlant.where(user_id: current_user.id, id: params[:plant_id].to_i).first.name
    end
    render_wizard
  end

  def new
    @chatbot_message = ChatbotMessage.new
  end
end
