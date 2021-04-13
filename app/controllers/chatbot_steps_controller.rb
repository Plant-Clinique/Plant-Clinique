require './lib/symptom_accessor'

class ChatbotStepsController < ApplicationController
  before_action :require_login
  before_action :set_shared_vars

  include Wicked::Wizard

  steps :choose_visit_type, :choose_plant, :select_symptoms, :answer_symptoms_questions, :display_possible_treatments # MORE STEPS GO HERE!
    
  def set_shared_vars
    @user = current_user
    @plant 
    @symptoms 
    @question 
    @symptom_assessor
    @symptom_causes
    @user_plants = UserPlant.where(user_id: current_user.id)
    @possible_treatments = []
  end
  
  def show
    case step
    when :choose_visit_type
      # @bot_message = ChatbotMessage.create(user_id: current_user.id,
      #                                     time_sent: Time.now.utc,
      #                                     from_bot: true,
      #                                     content: "hello user!")
      # @chatbot_message = ChatbotMessage.new
    when :choose_plant
      @plant = UserPlant.where(user_id: current_user.id, id: params[:plant_id].to_i).first
    when :select_symptoms
      @symptoms = @symptom_assessor.get_symptom_select_options
    when :answer_symptoms_questions
      @question = @symptom_assessor.get_question_using_cause(@symptom_causes[0])
    end

    render_wizard

  end

  def update
    @question_number = 0
    case step
    when :choose_plant
      @plant = UserPlant.where(user_id: current_user.id, id: params[:plant_id].to_i).first
    when :select_symptoms
      @plant = UserPlant.where(user_id: current_user.id, id: params[:plant_id].to_i).first
      @symptom_assessor = SymptomAssessor.new(@plant.plant_type)
      @symptoms = @symptom_assessor.get_symptom_select_options
    when :answer_symptoms_questions
      @plant = UserPlant.where(user_id: current_user.id, id: params[:plant_id].to_i).first
      @symptom_assessor = SymptomAssessor.new(@plant.plant_type)
      @symptom_id = params[:symptom_id].to_i
      @symptom_causes = @symptom_assessor.get_symptom_causes(@symptom_id)

      if params[:question_number]
        @question_number = params[:question_number].to_i 
      else
        @question_number = 0
      end

      if params[:symptom_question_response]
        diagnosis = @symptom_assessor.get_diagnosis(@plant.plant_type,@symptom_id,@question_number-1, params[:symptom_question_response].to_i)
        @possible_treatments.append()
      end

      if @question_number <= @symptom_causes.length
        @question = @symptom_assessor.get_question_using_cause(@symptom_causes[@question_number])
        @question_number += 1
      else
        jump_to(:display_possible_treatments)
      end
    end
    render_wizard
  end

  def new
    @chatbot_message = ChatbotMessage.new
  end

end
