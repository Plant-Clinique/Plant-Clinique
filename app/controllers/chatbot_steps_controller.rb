class ChatbotStepsController < ApplicationController
  before_action :require_login
  include Wicked::Wizard

  steps :choose_visit_type, :choose_plant, :select_symptoms, :answer_symptoms_questions, :display_possible_treatments # MORE STEPS GO HERE!

  def show
    @user = current_user
    render_wizard
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    render_wizard @user
  end
end
