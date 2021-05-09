class UserPlantsController < ApplicationController
  before_action :require_login
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
    @user_plant = UserPlant.new(user_id: params[:user_plant][:user_id],
                                name: params[:user_plant][:name],
                                age: params[:user_plant][:age],
                                plant_type: params[:user_plant][:plant_type],
                                img_url: fetch_plant_picture(params[:user_plant][:plant_type]),
                                description: params[:user_plant][:description])

    respond_to do |format|
      if @user_plant.save
        format.html { redirect_to current_user, notice: "User plant was successfully created." }
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
      if @user_plant.update(user_id: params[:user_plant][:user_id],
                            name: params[:user_plant][:name],
                            age: params[:user_plant][:age],
                            plant_type: params[:user_plant][:plant_type],
                            img_url: fetch_plant_picture(params[:user_plant][:plant_type]),
                            description: params[:user_plant][:description])
        format.html { redirect_to current_user, notice: "User plant was successfully updated." }
        format.json { render :show, status: :ok, location: @user_plant }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_plant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_plants/1 or /user_plants/1.json
  def destroy
    Reminder.where(user_plant_id: @user_plant.id).delete_all    
    @user_plant.destroy
    respond_to do |format|
      format.html { redirect_to users_url+"/#{current_user.id}", notice: "User plant was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def fetch_plant_picture(plant_type)
      begin
        plant_type = PlantType.where(trefle_id: plant_type).first.name.gsub(/\s/,"+")
        pixabay_response = "https://pixabay.com/api/?key=21149754-82925dfd4f7141a3bcd1aae55&image_type=photo&category=food&per_page=10&order=popular&safesearch=true&q=#{plant_type}"
        pictures = JSON.parse(Net::HTTP.get(
                                    URI.parse(
                                      pixabay_response
                                    )
                                  )
                                )['hits']
        if pictures.empty?
          return "https://cdn.pixabay.com/photo/2019/06/17/08/24/pastel-4279379_960_720.jpg"
        else
          pictures.sample["largeImageURL"]
        end
      rescue
        "https://cdn.pixabay.com/photo/2019/06/17/08/24/pastel-4279379_960_720.jpg"
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user_plant
      @user_plant = UserPlant.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_plant_params
      params.require(:user_plant).permit(:user_id, :name, :age, :plant_type, :img_url, :description)
    end
end
