json.extract! reminder, :id, :user_plant_id, :user_id, :tick_time, :description, :reminder_type, :interval, :created_at, :updated_at
json.url reminder_url(reminder, format: :json)
