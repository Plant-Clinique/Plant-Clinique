json.extract! user_plant, :id, :user_id, :name, :age, :plant_type, :img_url, :description, :created_at, :updated_at
json.url user_plant_url(user_plant, format: :json)
