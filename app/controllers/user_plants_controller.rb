class UserPlantsController < ApplicationController
  before_action :set_user_plant, only: %i[ show edit update destroy ]

  # GET /user_plants or /user_plants.json
  def index
    @user_plants = UserPlant.all
  end

  # GET /user_plants/1 or /user_plants/1.json
  def show
  end

  # GET /user_plants/new
  def new
    @user_plant = UserPlant.new
  end

  # GET /user_plants/1/edit
  def edit
  end

  # POST /user_plants or /user_plants.json
  def create
    @user_plant = UserPlant.new(user_plant_params)

    respond_to do |format|
      if @user_plant.save
        format.html { redirect_to @user_plant, notice: "User plant was successfully created." }
        format.json { render :show, status: :created, location: @user_plant }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_plants/1 or /user_plants/1.json
  def update
    respond_to do |format|
      if @user_plant.update(user_plant_params)
        format.html { redirect_to @user_plant, notice: "User plant was successfully updated." }
        format.json { render :show, status: :ok, location: @user_plant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_plants/1 or /user_plants/1.json
  def destroy
    @user_plant.destroy
    respond_to do |format|
      format.html { redirect_to user_plants_url, notice: "User plant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_plant
      @user_plant = UserPlant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_plant_params
      params.require(:user_plant).permit(:user_id, :name, :age, :plant_type, :img_url, :description)
    end
end
