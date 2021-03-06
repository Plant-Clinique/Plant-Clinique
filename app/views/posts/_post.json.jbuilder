json.extract! post, :id, :user_id, :topic, :title, :body, :create_at, :created_at, :updated_at
json.url post_url(post, format: :json)
