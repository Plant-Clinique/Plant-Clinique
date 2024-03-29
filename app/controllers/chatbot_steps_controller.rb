require './lib/symptom_accessor'
require 'json'

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
      @prompt = "Please choose your visit type."
    when :choose_plant
      @bot_message = ChatbotMessage.create(user_id: current_user.id,
        time_sent: Time.now.utc,
        from_bot: true,
        content: "Please choose your visit type.")
      @prompt = "Which plant do you want to check in today?"
      @user_message = ChatbotMessage.create(user_id: current_user.id,
        time_sent: Time.now.utc,
        from_bot: false,
        content: "Symptom assessment")
      @bot_message = ChatbotMessage.create(user_id: current_user.id,
        time_sent: Time.now.utc,
        from_bot: true,
        content: @prompt)
    when :select_symptoms
      jump_to(:choose_plant)
    when :answer_symptoms_questions
      jump_to(:choose_plant)
    when :display_possible_treatments
      if params[:possible_treatments]
        @possible_treatments = params[:possible_treatments]
      else
        @possible_treatments = "No possible treatments found. Feel free to ask about this in a forum!"
      end
      @prompt = "Below are some possible treatments:"
      @bot_message = ChatbotMessage.create(user_id: current_user.id,
        time_sent: Time.now.utc,
        from_bot: true,
        content: "#{@prompt}\n#{@possible_treatments}")
    end

    render_wizard

  end

  def update
    @question_number = 0
    @possible_treatments = []
    case step
    when :select_symptoms
      @plant = UserPlant.where(user_id: current_user.id, id: params[:plant_id].to_i).first
      @symptom_assessor = SymptomAssessor.new(@plant.plant_type)
      @symptoms = @symptom_assessor.get_symptom_select_options
      @prompt = "What symptom does #{@plant.name.titleize} have?"
      @user_message = ChatbotMessage.create(user_id: current_user.id,
        time_sent: Time.now.utc,
        from_bot: false,
        content: params[:content])
      @bot_message = ChatbotMessage.create(user_id: current_user.id,
        time_sent: Time.now.utc,
        from_bot: true,
        content: @prompt)
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

      if params[:possible_treatments]
        @possible_treatments = JSON.parse(params[:possible_treatments])
      else
        @possible_treatments = []
      end

      if params[:symptom_question_response]
        diagnosis = @symptom_assessor.get_diagnosis(@plant.plant_type,@symptom_id,@question_number-1, params[:symptom_question_response].to_i)
        if diagnosis
          @possible_treatments.append(diagnosis)
        end
      end

      if @question_number < @symptom_causes.length
        @question = @symptom_assessor.get_question_using_cause(@symptom_causes[@question_number])
        if !@question
          if @possible_treatments.empty?
            diagnosis = @symptom_assessor.get_questionless_diagnosis(@symptom_id,@question_number)
            @possible_treatments.append(diagnosis)
          end
          jump_to(:display_possible_treatments, possible_treatments: @possible_treatments)
        end
        @question_number += 1
      else
        jump_to(:display_possible_treatments, possible_treatments: @possible_treatments)
      end
      if params[:content]
        @user_message = ChatbotMessage.create(user_id: current_user.id,
          time_sent: Time.now.utc,
          from_bot: false,
          content: params[:content])
      end
      @user_message = ChatbotMessage.create(user_id: current_user.id,
        time_sent: Time.now.utc,
        from_bot: false,
        content: params[:symptom_question_response])
      @bot_message = ChatbotMessage.create(user_id: current_user.id,
        time_sent: Time.now.utc,
        from_bot: true,
        content: @question)
    end
    render_wizard
  end

  def new
    @chatbot_message = ChatbotMessage.new
  end

end
