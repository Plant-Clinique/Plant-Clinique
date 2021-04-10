class RemindersController < ApplicationController
  before_action :require_login
  before_action :set_reminder, only: %i[ show edit update destroy ]

  # GET /reminders or /reminders.json
  def index
    @reminders = Reminder.where(user_id: current_user)
  end

  # GET /reminders/1 or /reminders/1.json
  def show
  end

  # GET /reminders/new
  def new
    @reminder = Reminder.new
    @reminder_dropdown_list = reminder_type_dropdown
    @user_plant_dropdown = user_plant_dropdown
  end

  # GET /reminders/1/edit
  def edit
    @reminder_dropdown_list = reminder_type_dropdown
    @user_plant_dropdown = user_plant_dropdown
  end

  # POST /reminders or /reminders.json
  def create
    @reminder = Reminder.new(reminder_params)

    respond_to do |format|
      if @reminder.save
        format.html { redirect_to @reminder, notice: "Reminder was successfully created." }
        format.json { render :show, status: :created, location: @reminder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reminders/1 or /reminders/1.json
  def update
    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to @reminder, notice: "Reminder was successfully updated." }
        format.json { render :show, status: :ok, location: @reminder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1 or /reminders/1.json
  def destroy
    @reminder.destroy
    respond_to do |format|
      format.html { redirect_to reminders_url, notice: "Reminder was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reminder_params
      params.require(:reminder).permit(:user_plant_id, :user_id, :tick_time, :description, :reminder_type, :interval)
    end

    def reminder_type_dropdown
      return Reminder.reminder_enums
    end

    def user_plant_dropdown
      this_user_plants = UserPlant.where(user_id: current_user)
      return this_user_plants.pluck(:name).zip(this_user_plants.pluck(:id))
    end

end
