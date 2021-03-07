class Post < ApplicationRecord
    has_many :replies
    belongs_to :user
    enum topics: [:bugs, :disease, :color, :watering, :sunlight, :soil_care, :buying_plants, :temperature]
end
