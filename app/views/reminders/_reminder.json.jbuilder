json.extract! reminder, :id, :user_plant_id, :user_id, :reminder_time, :description, :type, :created_at, :updated_at
json.url reminder_url(reminder, format: :json)